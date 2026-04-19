#!/usr/bin/env -S nu --stdin
const LOCK_DIR = "/tmp/tmux-notify"
const REPLY_FILE = $"($LOCK_DIR)/reply"
const DATA_FILE = $"($LOCK_DIR)/data.nuon"
const PID_FILE = $"($LOCK_DIR)/pid"
const SCRIPT_PATH = path self
# display the actual notification in a tmux popup
def "main show-notification" [] {
    let n = try { open $DATA_FILE } catch {
        print --stderr $"Could not open ($DATA_FILE)"
        exit 1
    }
    let has_actions = $n.actions | is-not-empty
    let has_prompt = $n.I != null
    $"(ansi blue_bold)(ansi default_underline)($n.summary)(ansi reset)\n\n($n.body | default 'No body')" | less -R
    if $has_prompt {
        if $has_actions { print $"(ansi bg_red)Hit enter to choose an action instead(ansi reset)" }
        print --no-newline $"($n.I)\n> "
        let msg = input --default ""
        if ($msg | is-not-empty) or (not $has_actions) {
            $msg | save --force $REPLY_FILE
            return
        }
    }
    if $has_actions {
        $n.actions | items {|k, v| {id: $k, display: $v} } | input list | get --optional id | default "" | save --force $REPLY_FILE
    } else { touch $REPLY_FILE }
}
# Acquire tmux-notify lock
def "main lock" [
    pid: int # the process id to give the lock to
] {
    mut waited = 0
    loop {
        if (^mkdir $LOCK_DIR | complete).exit_code == 0 {
            try {
                $pid | save $PID_FILE
            } catch { exit 6 }
            return
        } else {
            let locking = (try {
                open $PID_FILE | into int
            } catch { 0 })
            if $locking == 0 or (ps | where pid == $locking | is-empty) or $waited > 300 {
                try { rm --recursive $LOCK_DIR } catch { sleep 1sec }
            } else {
                sleep 1sec
                $waited += 1
            }
        }
    }
}
# tmux-notify 0.2.0 - A drop-in replacement for notify-send for the Tmux terminal.
def "main --" [
    summary: string # The title of the notification
    body?: string # The message body (optional)
    --tui # don't try notify-send if notificaton daemon running
    --actions: string # (internal) a wrapper wraps --action/-A here as nuon
    --app-name (-a): string # Name of the app sending the notification
    --expire-time (-t): int # Timeout in milliseconds
    --urgency (-u): string # (ignored) low normal or critical
    --icon (-i): string # (ignored) Path to an icon
    --category (-c): string # (ignored) Notification category
      # nu-lint-ignore: unused_parameter
    --wait (-w)  # (ignored) Wait for the notification to be closed
    --print-id (-p) # (ignored) Print the notification ID
    --reply (-I): string # Specify a reply prompt
      # nu-lint-ignore: unused_parameter
    --action (-A): string, # pass actions to tmux-notify
]: any -> string {
    mut args = {
        a: ($app_name | default null)
        t: ($expire_time | default null)
        u: ($urgency | default null)
        i: ($icon | default null)
        c: ($category | default null)
        I: ($reply | default null)
        p: $print_id
        actions: (
            $actions | decode base32 | decode | from nuon
        )
        summary: $summary
        body: $body
    }
    main lock $nu.pid
    $args | to nuon | save --force $DATA_FILE
    main display-popup $args
}
def "main display-popup" [args: record] {
    job spawn {||
        nohup tmux display-popup -x R -y 0 -w 60 -h 20 -E -E -T ($args.a | default " Notification ") $"($nu.current-exe) ($SCRIPT_PATH) show-notification" o+e> /dev/null
    }
    while not ($REPLY_FILE | path exists) { sleep 200ms }
    sleep 200ms # wait for the data to be written I guess
    open --raw $REPLY_FILE
}
# The wrapper to group -A and --action, I use this until I find a reliable
# way to handle that in nushell
def --wrapped main [
    ...args: string, # args
]: any -> string {
    if (ps | where name in [swaync dunst notification-daemon notify mate xfce] | is-not-empty) and not ("--tui" in $args) { exec notify-send ...$args }

    mut clean_args = []
    mut actions = {}
    mut i = 0
    mut wait = false

    while $i < ($args | length) {
        let current = ($args | get --optional $i)
        if $current in ["-h" "--help" "-I" "--reply" "-w" "--wait"] { $wait = true }
        if $current in ["-A" "--action"] {
            let pair = ($args | get --optional ($i + 1) | split row --number 2 '=')
            $actions = ($actions | insert ($pair.0) ($pair | get --optional 1 | default $pair.0))
            $i += 2
            $wait = true
        } else if $current in ["--wait" "-w" "--tui"] {
            $i += 1
        } else {
            $clean_args ++= [$current]
            $i += 1
        }
    }
    # way to make sure this is interpreted as a string and not a record
    let actions = $actions | to nuon | encode base32
    if $wait { ^$nu.current-exe $SCRIPT_PATH -- ...$clean_args --actions $actions } else {
        let args = $clean_args
        job spawn {||
           nohup $nu.current-exe $SCRIPT_PATH -- ...$args --actions $actions o+e> /dev/null
        }
        # FIX: Remove this
        # without this the script exits and the task doesn't run
        sleep 500ms
    }
}

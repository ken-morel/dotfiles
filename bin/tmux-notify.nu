#!/usr/bin/env -S nu --stdin

const LOCK_DIR = "/tmp/tmux-notify"
const REPLY_FILE = $"($LOCK_DIR)/reply"
const DATA_FILE = $"($LOCK_DIR)/data.nuon"
const PID_FILE = $"($LOCK_DIR)/pid"

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
                try { rm --recursive $LOCK_DIR } catch {
                    sleep 1sec
                }
            } else {
                sleep 1sec
                $waited += 1
            }
        }
    }
}
# process spawned by
def "main show-notification" [] {
    let n = try { open $DATA_FILE } catch { print --stderr $"Could not open ($DATA_FILE)"; exit 1 }
    print $n
    $"# ($n.summary)\n\n($n.body | default '_No body_')" | lowdown -tterm --term-columns 54 --term-width 58 | less -R
    if $n.I != null {
        print --no-newline $"($n.I): "
        try {
            input --default "" | save --force $REPLY_FILE
        }
    } else {
        try { touch $REPLY_FILE }
    }

}
def relay_swaync [notif: record]: any -> nothing { # nu-lint-ignore: kebab_case_commands
    if (ps | where name == swaync | is-not-empty) {
        mut args = []
        for row in ($notif | transpose  key value) {
            if $row.value != null {
                if ($row.key | str length) == 1 and (($row.value | describe) != bool or $row.value) {
                    $args ++= [$"-($row.key)"]
                }
                if ($row.value | describe) != bool {
                    $args ++= [$row.value]
                }
            }
        }
        exec notify-send ...$args
    }
}
# tmux-notify 0.2.0 - A drop-in replacement for notify-send for the Tmux terminal.
def main [
     summary: string, # The title of the notification
     body?: string, # The message body (optional)
     --app-name (-a): string, # Name of the app sending the notification
     --expire-time (-t): int, # (ignored) Timeout in milliseconds
     --urgency (-u): string, # (ignored) low normal or critical
     --icon (-i): string, # (ignored) Path to an icon
     --category (-c): string, # Notification category
     --wait (-w) , # (ignored) Wait for the notification to be closed
     --action (-A): any, # This can be a single string or a list
     --print-id (-p), # (ignored) Print the notification ID
     --reply (-I): string # Specify a reply prompt
     --help (-h), # Show help
 ]: any -> string {
    if $help {
        main help
        exit 0
    }
    let args = {
        a: ($app_name | default null)
        t: ($expire_time | default null)
        u: ($urgency | default null)
        i: ($icon | default null)
        c: ($category | default null)
        w: ($wait | default null)
        A: ($action | default null)
        I: ($reply | default null)
        p: $print_id
        summary: $summary
        body: $body
    }

    relay_swaync $args
    main lock $nu.pid

    loop {
        try {
            $args | to nuon | save $DATA_FILE
            break
        } catch {
            rm $DATA_FILE
        }
    }

    display-popup $args
}

def display-popup [args: record]: any -> string {
    tmux display-popup -x R -y 0 -w 60 -h 20 -E -E -T ($args.a | default " Notification ") "tmux-notify show-notification"
    while not ($REPLY_FILE | path exists) {
        # if (job list | is-empty) {
        #     error make  {msg: "Notification killed without reply"}
        #     return ""
        # }
        sleep 200ms
    }
    let reply = try { open --raw $REPLY_FILE } catch { "" }
    try {
       rm --recursive  $LOCK_DIR
    }
    $reply
}

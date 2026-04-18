# config nu --doc | nu-highlight | bat

# use std/dirs  shells-aliases *
# `ask confirm` plugin


$env.config = {
  # show_banner : false,
  edit_mode : vi
  use_kitty_protocol: true
  highlight_resolved_externals: true
  cursor_shape: {
    vi_insert: line
    vi_normal: block
  }
  buffer_editor : hx
  history: {
    file_format: sqlite # plaintext
    sync_on_enter: true # default with sqlite
  }
  rm: {
    always_trash : true
  }
  completions: {
    algorithm : fuzzy
    external: {
      max_results: 100
      enable: true
      completer: {|spans|
        fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
          | from tsv --flexible --noheaders --no-infer
          | rename value description
          | update value {|row|
            let value = $row.value
            let need_quote = ['\' ',' '[' ']' '(' ')' ' ' '\t' "'" '"' "`"] | any {$in in $value}
            if ($need_quote and ($value | path exists)) {
              let expanded_path = if ($value starts-with ~) {$value | path expand --no-symlink} else {$value}
              $'"($expanded_path | str replace --all "\"" "\\\"")"'
            } else {
              $value
            }
          }
        }
    }
  }

  table: {
    mode: psql
    header_on_separator: true
  }
  filesize: {
    precision: 2
  }
  color_config: {
    filesize : {|x| if $x == 0b { 'dark_gray' } else if $x < 1mb { 'cyan' } else { 'blue' } }
    bool: {|x| if $x { 'green' } else { 'light_red' } }
  }
    hooks: {
        command_not_found: {|cmd| # from: https://github.com/nushell/nu_scripts/blob/main/nu-hooks/nu-hooks/command_not_found/did_you_mean.nu
            let commands_in_path = (

                    $env.PATH | each {|directory|
                        if ($directory | path exists) {
                            ls $directory | get name | path parse | update parent "" | path join
                        }
                    }

                | flatten
                | wrap cmd
            )

            let closest_commands = (
                $commands_in_path
                | insert distance {|it|
                    $it.cmd | str distance $cmd
                }
                | uniq
                | sort-by distance
                | get cmd
                | first 3
            )

            let pretty_commands = (
                $closest_commands | each {|cmd|
                    $"    (ansi {fg: "default" attr: "di"})($cmd)(ansi reset)"
                }
            )

            $"\ndid you mean?\n($pretty_commands | str join "\n")"
        }
    }
}
$env.config.keybindings ++= [{
    name: completion_menu
    modifier: control
    keycode: char_x
    mode: vi_insert
    event: { send: menu name: completion_menu }
}]




# source ~/.cache/nushell/carapace.nu
source /tmp/nushell/starship.nu
source /tmp/nushell/zoxide.nu
source /tmp/nushell/keychain.nu

alias ll = eza -l --icons --git --header
alias la = eza -a --icons --git --header
alias tree = exa --tree --icons

alias fg = job unfreeze

alias lss = ls | sort-by size
alias lsm = ls | sort-by modified

# alias man = mancha

def gpo [] {
    git push --set-upstream origin (git branch --show-current)
}
alias gaa = git add --all

def gc [...args] {
  git commit -m $"($args | str join ' ')"
}

def --env y [...args] {
    let tmp = (mktemp)
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp | str trim)
    if ($cwd != "" and $cwd != $env.PWD) {
        cd $cwd
    }
    rm $tmp
}

alias 7zc  = 7z a -t7z -m0=lzma2 -mx=9 -md=256m -mfb=273 -ms=on
alias nchat = with-env {TERM: xterm-ghostty} { nchat }

def e [name: path] {
  hx (which $name).path.0
}

def nix-clean [] {
  nix-collect-garbage  -d
  nix-store  --optimize
}

alias build-hx = with-env {
  HELIX_DISABLE_AUTO_GRAMMAR_BUILD: 1
  HELIX_DEFAULT_RUNTIME: /usr/lib/helix/runtime
} { cargo build --profile opt --locked }


def same-hash [f1: path, f2: path]: nothing -> bool {
   (open --raw $f1 | hash md5 ) == (open --raw $f2 | hash md5)
}


# Why did dumb me not do this sooner :C
alias .s = sudo systemctl
alias ".s dr" = sudo systemctl daemon-reload
alias ".s r" = sudo systemctl restart
alias ".s s" = sudo systemctl start
alias ".s s-" = sudo systemctl stop
alias ".s m" = sudo systemctl mask
alias ".s m-" = sudo systemctl unmask
alias ".s e" = sudo systemctl enable
alias ".s d" = sudo systemctl disable
alias ".s en" = sudo systemctl enable --now
alias ".s dn" = sudo systemctl disable --now

alias .su = systemctl --user
alias ".su dr" = systemctl --user daemon-reload
alias ".su r" = systemctl --user restart
alias ".su s" = systemctl --user start
alias ".su s-" = systemctl --user stop
alias ".su m" = systemctl --user mask
alias ".su m-" = systemctl --user unmask
alias ".su e" = systemctl --user enable
alias ".su d" = systemctl --user disable
alias ".su en" = systemctl --user enable --now
alias ".su dn" = systemctl --user disable --now


# completions
use /home/engon/.config/nushell/nu_scripts/custom-completions/adb/adb-completions.nu *
use /home/engon/.config/nushell/nu_scripts/custom-completions/bat/bat-completions.nu *
use /home/engon/.config/nushell/nu_scripts/custom-completions/cargo/cargo-completions.nu *
# Use nu
# use /home/engon/.config/nushell/nu_scripts/custom-completions/curl/curl-completions.nu *
use /home/engon/.config/nushell/nu_scripts/custom-completions/dart/dart-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/docker/docker-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/flutter/flutter-completions.nu *
use /home/engon/.config/nushell/nu_scripts/custom-completions/gh/gh-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/git/git-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/glow/glow-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/just/just-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/make/make-completions.nu *
use /home/engon/.config/nushell/nu_scripts/custom-completions/man/man-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/mvn/mvn-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/mysql/mysql-completions.nu *
use /home/engon/.config/nushell/nu_scripts/custom-completions/nano/nano-completions.nu *
use /home/engon/.config/nushell/nu_scripts/custom-completions/nix/nix-completions.nu *
use /home/engon/.config/nushell/nu_scripts/custom-completions/npm/npm-completions.nu *
use /home/engon/.config/nushell/nu_scripts/custom-completions/pnpm/pnpm-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/pre-commit/pre-commit-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/pytest/pytest-completions.nu *
use /home/engon/.config/nushell/nu_scripts/custom-completions/rustup/rustup-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/ssh/ssh-completions.nu *
use /home/engon/.config/nushell/nu_scripts/custom-completions/tar/tar-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/typst/typst-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/uv/uv-completions.nu *
use /home/engon/.config/nushell/nu_scripts/custom-completions/virsh/virsh-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/vscode/vscode-completions.nu *
use /home/engon/.config/nushell/nu_scripts/custom-completions/yarn/yarn-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/zellij/zellij-completions.nu *
use /home/engon/.config/nushell/nu_scripts/custom-completions/zig/zig-completions.nu *
# use /home/engon/.config/nushell/nu_scripts/custom-completions/zoxide/zoxide-completions.nu *

# modules
# use /home/engon/.config/nushell/nu_scripts/modules/after/after.nu
use /home/engon/.config/nushell/nu_scripts/modules/background_task/task.nu
use /home/engon/.config/nushell/nu_scripts/modules/data_extraction/ultimate_extractor.nu extract
use /home/engon/.config/nushell/nu_scripts/modules/docker/mod.nu
# use /home/engon/.config/nushell/nu_scripts/modules/formats/from-cpuinfo.nu *
# use /home/engon/.config/nushell/nu_scripts/modules/formats/from-dmidecode.nu *
use /home/engon/.config/nushell/nu_scripts/modules/formats/from-env.nu *
use /home/engon/.config/nushell/nu_scripts/modules/formats/to-ini.nu *
use /home/engon/.config/nushell/nu_scripts/modules/formats/to-number-format.nu *
use /home/engon/.config/nushell/nu_scripts/modules/git/git.nu *
use /home/engon/.config/nushell/nu_scripts/modules/maths/math_functions.nu *
use /home/engon/.config/nushell/nu_scripts/modules/network/ssh.nu
use /home/engon/.config/nushell/nu_scripts/modules/nix/nix.nu ns
alias nix-search = print "Use `ns` you dummy!!"
use /home/engon/.config/nushell/nu_scripts/modules/virtual_environments/venv.nu
# use /home/engon/.config/nushell/nu_scripts/modules/weather/nu.nu
# use /home/engon/.config/nushell/nu_scripts/modules/zvm/zvm.nu *
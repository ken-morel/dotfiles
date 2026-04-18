# env.nu
#
# Installed by:
# version = "0.111.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.
#
use std "path add"
const path_add = [
    /home/engon/.zigup
    /home/engon/.zig
    /home/engon/.dprint/bin
    /home/engon/.nix-profile/bin
    /home/engon/.juliaup/bin
    /home/engon/.config/llama.cpp
    /home/engon/apps/flutter/bin
    /home/engon/apps/llama.cpp/build/bin
    /home/engon/go/bin
    /home/engon/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin
    /home/engon/.julia/bin
    /home/engon/.cargo/bin
    /home/engon/.config/bin
    /home/engon/.local/bin
    /home/engon/bin
    /opt/android-sdk/cmdline-tools/latest/bin
    /home/engon/.bun/bin
    /home/engon/.zigup
    /home/engon/.zig
    /nix/var/nix/profiles/default/bin
    /usr/local/sbin
    /usr/local/bin
    /usr/bin
    /usr/bin/site_perl
    /usr/bin/vendor_perl
    /usr/bin/core_perl
    /usr/lib/rustup/bin
    /nix/var/nix/profiles/default/bin
    /home/engon/.dprint/bin
    /home/engon/.nix-profile/bin
    /home/engon/.juliaup/bin
    /home/engon/.config/llama.cpp
    /home/engon/apps/flutter/bin
    /home/engon/apps/llama.cpp/build/bin
    /home/engon/go/bin
    /home/engon/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin
    /home/engon/.julia/bin
    /home/engon/.cargo/bin
    /home/engon/.config/bin
    /home/engon/.local/bin
    /home/engon/bin
    /opt/android-sdk/cmdline-tools/latest/bin
    /home/engon/.bun/bin
    /usr/local/sbin
    /usr/local/bin
    /usr/bin
    /usr/bin/site_perl
    /usr/bin/vendor_perl
    /usr/bin/core_perl
    /usr/lib/rustup/bin
    /home/engon/.dprint/bin
    /home/engon/.nix-profile/bin
    /home/engon/.juliaup/bin
    /home/engon/.config/llama.cpp
    /home/engon/apps/flutter/bin
    /home/engon/apps/llama.cpp/build/bin
    /home/engon/go/bin
    /home/engon/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin
    /home/engon/.julia/bin
    /home/engon/.cargo/bin
    /home/engon/.config/bin
    /home/engon/.local/bin
    /home/engon/bin
    /opt/android-sdk/cmdline-tools/latest/bin
    /home/engon/.bun/bin
    /home/engon/.config/carapace/bin
    /home/engon/.zigup
    /home/engon/.zig
    /nix/var/nix/profiles/default/bin
    /usr/local/sbin
    /usr/local/bin
    /usr/bin
    /usr/bin/site_perl
    /usr/bin/vendor_perl
    /usr/bin/core_perl
    /usr/lib/rustup/bin
    /nix/var/nix/profiles/default/bin
    /home/engon/.dprint/bin
    /home/engon/.nix-profile/bin
    /home/engon/.juliaup/bin
    /home/engon/.config/llama.cpp
    /home/engon/apps/flutter/bin
    /home/engon/apps/llama.cpp/build/bin
    /home/engon/go/bin
    /home/engon/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin
    /home/engon/.julia/bin
    /home/engon/.cargo/bin
    /home/engon/.config/bin
    /home/engon/.local/bin
    /home/engon/bin
    /opt/android-sdk/cmdline-tools/latest/bin
    /home/engon/.bun/bin
    /usr/local/sbin
    /usr/local/bin
    /usr/bin
    /usr/bin/site_perl
    /usr/bin/vendor_perl
    /usr/bin/core_perl
    /usr/lib/rustup/bin
]
for $path in $path_add {
    if not ($path in $env.PATH) { path add $path }
}
load-env {
    XDG_DATA_DIRS: "/usr/local/share:/usr/share:/home/engon/.nix-profile/share:/nix/var/nix/profiles/default/share"
    COLORTERM: truecolor
    EDITOR: hx
    VISUAL: hx
    LIBVIRT_DEFAULT_URI: "qemu:///system"
    BUN_INSTALL: /home/engon/.bun
    LANG: en_GB.UTF-8
    __EGL_VENDOR_LIBRARY_DIRS: /usr/share/glvnd/egl_vendor.d # for julia Mousetrap.jl
    DPRINT_INSTALL: /home/engon/.dprint
    SSH_ASKPASS: /usr/bin/ksshaskpass
    BAT_STYLE: "changes,header-filename,header-filesize,rule,snip"
    CHROME_EXECUTABLE: google-chrome-stable
}

try {
    mkdir /tmp/nushell
    starship init nu | save --force /tmp/nushell/starship.nu
    zoxide init nushell | save --force /tmp/nushell/zoxide.nu
    keychain ~/.ssh/id_ed25519 --eval | parse "{env}={val}; export {_}" | each {|e| $"$env.($e.env) = ($e.val)" } | str join "\n" | save --force /tmp/nushell/keychain.nu
    # carapace _carapace nushell | save --force /tmp/nushell/carapace.nu
}

source ~/bakop/api-keys.nu

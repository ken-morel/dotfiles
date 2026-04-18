#!/usr/bin/fish

alias hypr 'hyprctl dispatch'
alias workspace 'hypr workspace'

alias h3tab 'hypr hy3:makegroup tab'

alias special 'hyprctl dispatch togglespecialworkspace'

function ghost
    hexec ghostty -e "$argv"
end
function ghostmux
    ghost tmux attach-session -t $argv[1]
end

function hexec
    hypr exec "$argv"
end

workspace 3

hexec qutebrowser
sleep 4

special music

ghostmux monitors

sleep 2

h3tab

hexec pavucontrol
hexec blueman-manager
hexec uget-gtk
hexec kdeconnect-app

sleep 4

special music

workspace 3

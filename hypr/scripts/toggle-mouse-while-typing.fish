#!/usr/bin/env fish

set dev synps/2-synaptics-touchpad
set state /tmp/hypr-config-touchpad-typing-state

# Initialize state file if it doesn't exist
if not test -f "$state"
    echo true >"$state"
end

set CURRENT_STATE (cat "$state")

if test "$CURRENT_STATE" = true
    hyprctl keyword "device[$dev]:disable_while_typing" false
    echo false >"$state"
    notify-send Touchpad "Disable-while-typing: OFF"
else
    hyprctl keyword "device[$dev]:disable_while_typing" true
    echo true >"$state"
    notify-send Touchpad "Disable-while-typing: ON"
end

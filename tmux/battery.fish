#!/usr/bin/fish

function battery_status
    set -l capacity_path /sys/class/power_supply/BAT0/capacity
    set -l status_path /sys/class/power_supply/BAT0/status

    if not test -r "$capacity_path" -a -r "$status_path"
        echo "󰁹 ?%"
        return 1
    end

    set -l capacity_str (cat "$capacity_path" 2>/dev/null)
    set -l bat_state (cat "$status_path" 2>/dev/null)

    # Clean capacity: remove whitespace/newlines
    set -l capacity (string trim "$capacity_str")

    if test -z "$capacity" -o -z "$bat_state"
        echo "󰁹 ?%"
        return 1
    end

    set -l state (string lower "$bat_state")

    # Special case: exactly 100% → show fully charged icon, regardless of status
    if test "$capacity" -eq "100"
        echo "󰂂 100%"
        return 0
    end

    switch "$state"
        case "charging"
            if test "$capacity" -ge "95"
                echo "󰂂 $capacity%"
            else if test "$capacity" -ge "80"
                echo "󰁿 $capacity%"
            else if test "$capacity" -ge "50"
                echo "󰁾 $capacity%"
            else
                echo "󰁽 $capacity%"
            end

        case "discharging"
            if test "$capacity" -ge "90"
                echo "󰂎 $capacity%"
            else if test "$capacity" -ge "70"
                echo "󰁺 $capacity%"
            else if test "$capacity" -ge "40"
                echo "󰁻 $capacity%"
            else if test "$capacity" -ge "20"
                echo "󰁼 $capacity%"
            else
                echo "󰁽 $capacity%"
            end

        case "full"
            echo "󰂂 100%"

        case "not charging" "unknown"
            if test "$capacity" -ge "90"
                echo "󰂎 $capacity%"
            else if test "$capacity" -ge "70"
                echo "󰁺 $capacity%"
            else if test "$capacity" -ge "40"
                echo "󰁻 $capacity%"
            else
                echo "󰁼 $capacity%"
            end

        case "*"
            if test "$capacity" -ge "90"
                echo "󰂎 $capacity%"
            else if test "$capacity" -ge "70"
                echo "󰁺 $capacity%"
            else if test "$capacity" -ge "40"
                echo "󰁻 $capacity%"
            else if test "$capacity" -ge "20"
                echo "󰁼 $capacity%"
            else
                echo "󰁽 $capacity%"
            end
    end
end

battery_status
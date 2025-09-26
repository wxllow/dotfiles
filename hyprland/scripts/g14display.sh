#!/bin/bash

refresh_rate=$(hyprctl monitors -j | jq -r '.[]
    | select(.description == "Samsung Display Corp. ATNA40CU05-0")
    | .refreshRate')
rounded_rate=$(printf "%.0f" "$refresh_rate")

if [[ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]]; then
    STATUS=$(cat /sys/class/power_supply/ACAD/online)

    FPS=60
    
    if [[ "$STATUS" -eq 1 ]]; then
        FPS=120
    fi


    if (( rounded_rate != FPS )); then
        hyprctl keyword monitor "desc:Samsung Display Corp. ATNA40CU05-0,2880x1800@${FPS},auto,1.666667,bitdepth,10,vrr,1"
    
        sleep 0.5

        systemctl --user restart hyprpaper
    fi
fi

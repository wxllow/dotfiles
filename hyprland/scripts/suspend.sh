#!/bin/bash
swayidle -w \
    timeout 180 'swaylock -d --grace 10' \
    timeout 600 'hyprctl dispatch dpms off' \
    timeout 600 '~/.config/hypr/scripts/sleep.sh' \
    resume 'hyprctl dispatch dpms on' \
    after-resume 'hyprctl dispatch dpms on' \
    before-sleep 'swaylock' \
    lock 'swaylock'

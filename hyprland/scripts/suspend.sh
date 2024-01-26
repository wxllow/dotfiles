#!/bin/bash
swayidle -w \
    timeout 120 'swaylock -d' \
    timeout 600 'hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' \
    after-resume 'hyprctl dispatch dpms on' \
    lock 'swaylock -d'

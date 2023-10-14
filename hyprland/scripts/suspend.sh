#!/bin/bash
swayidle -w \
timeout 120 'gtklock -d' \
timeout 600 'hyprctl dispatch dpms off' \
resume 'hyprctl dispatch dpms on' \
after-resume 'hyprctl dispatch dpms on' \
lock 'gtklock -d'

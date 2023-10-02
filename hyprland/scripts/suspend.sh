#!/bin/bash
swayidle -w \
timeout 120 ' gtklock ' \
timeout 600 ' hyprctl dispatch dpms off' \
resume ' hyprctl dispatch dpms on' \
before-sleep ' gtklock '

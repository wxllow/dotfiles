#!/usr/bin/env bash

# Base directory for icons (configure this!)
DIR="$HOME/.config/hypr/icons"

# Get the UPower battery device (usually BAT0)
BATTERY_DEVICE=$(upower -e | grep -m1 'BAT')

# Get charging state (e.g., "charging", "discharging", "fully-charged")
STATE=$(upower -i "$BATTERY_DEVICE" | awk '/state:/ {print $2}')

# Get battery percentage as integer (strip the % sign)
PERCENT=$(upower -i "$BATTERY_DEVICE" | awk '/percentage:/ {gsub("%","",$2); print $2}')

ICON=""

if [[ "$STATE" == "charging" ]]; then
    ICON="$DIR/charging.png"
else
    # Map percentage to 7 levels (1–7)
    if   (( PERCENT <= 15 )); then ICON="$DIR/batt1.png"
    elif (( PERCENT <= 30 )); then ICON="$DIR/batt2.png"
    elif (( PERCENT <= 45 )); then ICON="$DIR/batt3.png"
    elif (( PERCENT <= 60 )); then ICON="$DIR/batt4.png"
    elif (( PERCENT <= 75 )); then ICON="$DIR/batt5.png"
    elif (( PERCENT <= 90 )); then ICON="$DIR/batt6.png"
    else                           ICON="$DIR/batt7.png"
    fi
fi

echo "$ICON"

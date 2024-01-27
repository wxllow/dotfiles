if command -v brave &> /dev/null
then 
    brave --ozone-platform-hint=wayland --password-store=gnome
else
    brave-browser --ozone-platform-hint=wayland --password-store=gnome
fi

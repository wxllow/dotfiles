if [[ $(cat ~/.local/share/AUTO_SLEEP) == "1" ]]; then
  systemctl suspend
fi

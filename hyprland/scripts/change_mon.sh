case $(hyprctl activeworkspace | grep monitorID | xargs | cut -d " " -f 2) in
  1)
    hyprctl dispatch workspace 1
    ;;
  0)
    hyprctl dispatch workspace 11
    ;;
esac

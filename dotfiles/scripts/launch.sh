#/bin/bash

sleep 1

hyprctl dispatch exec [workspace 1 silent] code
hyprctl dispatch exec [workspace 2 silent] dolphin
hyprctl dispatch exec [workspace 3 silent] alacritty
hyprctl dispatch exec [workspace 5 silent] firefox
hyprctl dispatch exec [workspace 10 silent] spotify
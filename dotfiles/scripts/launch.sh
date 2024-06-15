#/bin/bash

sleep 5

hyprctl dispatch exec [workspace 1 silent] code
sleep 1
hyprctl dispatch exec [workspace 3 silent] alacritty
sleep 1
hyprctl dispatch exec [workspace 5 silent] firefox
sleep 1
hyprctl dispatch exec [workspace 10 silent] spotify
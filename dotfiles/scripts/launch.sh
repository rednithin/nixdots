#/bin/bash

sleep 3

hyprctl dispatch exec [workspace 1 silent] code
sleep 2
hyprctl dispatch exec [workspace 3 silent] alacritty
sleep 2
hyprctl dispatch exec [workspace 5 silent] firefox
sleep 2
hyprctl dispatch exec [workspace 10 silent] spotify
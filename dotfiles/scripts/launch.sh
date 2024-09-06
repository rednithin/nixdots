#/bin/bash

sleep 2

hyprctl dispatch exec [workspace 1 silent] code
sleep 1
hyprctl dispatch exec [workspace 2 silent] dolphin
sleep 1
hyprctl dispatch exec [workspace 3 silent] kitty
sleep 1
hyprctl dispatch exec [workspace 5 silent] firefox
sleep 1
hyprctl dispatch exec [workspace 10 silent] spotify
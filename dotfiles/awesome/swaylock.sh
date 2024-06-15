#!/bin/sh

xautolock -detectsleep -time 1 -locker "swaylock -n -c 4B0082" -notify 30 -notifier "notify-send -u critical -t 10000 'Locking Screen' 'Locking screen in 30 seconds'" -corners "----" -cornersize 100 -killer "systemctl suspend" -killtime 10

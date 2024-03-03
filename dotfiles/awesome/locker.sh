#!/bin/sh

xautolock -detectsleep -time 1 -locker "i3lock -n -c 4B0082" -notify 30 -notifier "notify-send -u critical -t 10000 'Locking Screen' 'LOCKING screen in 30 seconds'" -corners "----" -cornersize 100 -killer "systemctl suspend" -killtime 10

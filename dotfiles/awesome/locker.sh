#!/bin/sh

xautolock -detectsleep -time 1 -locker "i3lock -n -c 008080" -notify 30 -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 20 seconds'" -corners "----" -cornersize 100 -killer "systemctl hibernate" -killtime 10

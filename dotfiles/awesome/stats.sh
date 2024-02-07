#!/bin/bash

function mem() {
  FREE_OUTPUT=`free -m | grep Mem` 
  CURRENT_RAM_USAGE=`echo $FREE_OUTPUT | cut -f3 -d' '`

  echo "🧠 $CURRENT_RAM_USAGE MB"
}

function temp() {
  TEMP=$(sensors | grep "+" | head -n 1 | grep -oP "(\d+\.\d+°C)" | head -n 1)
  echo "🔥 $TEMP"  
}

function disk() {
  DISK_USAGE=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}' | xargs)
  echo "🗄️ $DISK_USAGE"  
}

function vol() {
  # bat /proc/asound/cards
  VOLUME="$(amixer sget Master | awk -F"[][]" '/Left:/ { print $2 }')"
  echo "🔉 $VOLUME"
}

function increase_vol() {
  # bat /proc/asound/cards
  amixer sset Master 5%+
}

function decrease_vol() {
  # bat /proc/asound/cards
  amixer sset Master 5%-
}

function mute_vol() {
  # bat /proc/asound/cards
  amixer sset Master 0%
}


function cpu() {
  CPU_USAGE=$(top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}')
  echo "🖥️ $CPU_USAGE%"
}

function pkgs_to_update() {
  PKGS_TO_UPGRADE=$(checkupdates | wc -l)
  echo "📦 $PKGS_TO_UPGRADE"
}

if [[ $# -eq 0 ]] ; then
  printf "Requires 1 argument\n"
  exit 1
fi

if [ "$(type -t $1)" = 'function' ]; then
  $1 | awk '{$1=$1};1'
else
  printf "Unknown function. Try [mem|cpu|disk]\n"
fi


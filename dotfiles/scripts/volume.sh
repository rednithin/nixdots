#!/usr/bin/env bash

# Function to get currently used sink
get_current_sink() {
    CURRENT_SINK=$(pactl info | grep 'Default Sink' | awk '{print $3}')
    echo "$CURRENT_SINK"
}

# Function to get current volume percentage of the default sink
get_current_volume() {
    DEFAULT_SINK=$(get_current_sink)
    CURRENT_VOLUME=$(pactl list sinks | grep -A 15 "$DEFAULT_SINK" | grep 'Volume: front' | awk '{print $5}')
    echo "${CURRENT_VOLUME%?}"  # Remove the '%' sign
}

toggle_mute() {
    local DEFAULT_SINK=$(get_current_sink)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
}


# Function to increase volume by 5% if below 150%
increase_volume_if_needed() {
    local current_volume=$(get_current_volume)
    if [[ $current_volume -lt 150 ]]; then
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        echo "Volume increased by 5%."
    else
        echo "Volume is already at or above 150%."
    fi
}

# Function to decrease volume by 5% if above 150%
decrease_volume_if_needed() {
    local current_volume=$(get_current_volume)
    if [[ $current_volume -gt 0 ]]; then
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        echo "Volume decreased by 5%."
    else
        echo "Volume is already below or at 150%."
    fi
}

# Check if no arguments are provided
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <command>"
    exit 1
fi

# Read the first argument (command)
case "$1" in
    "up")
        increase_volume_if_needed
        # Replace with the actual command you want to run
        ;;
    "down")
        decrease_volume_if_needed
        # Replace with the actual command you want to run
        ;;
    "get")
        get_current_volume
        # Replace with the actual command you want to run
        ;;
    "mute")
        toggle_mute
        # Replace with the actual command you want to run
        ;;
    *)
        echo "Unknown command: $1"
        exit 1
        ;;
esac
#!/usr/bin/env bash

# echo "Hello"
upower -d | grep 'energy-rate:' | head -n1 | tr -s ' ' | cut -f 3,4 -d' '
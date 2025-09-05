#!/usr/bin/env bash

MAIN_KB=$(~/.config/waybar/scripts/get_main_kb.sh)

# Switch to next layout
hyprctl switchxkblayout "$MAIN_KB" next

# Signal Waybar to refresh module
pkill -RTMIN+10 waybar

#!/usr/bin/env bash

# Fetch name of main keyboard
MAIN_KB=$(~/.config/waybar/scripts/get_main_kb.sh)

# Get active layout of main keyboard
ACTIVE=$(hyprctl devices -j | jq -r \
    --arg kb "$MAIN_KB" \
    '.keyboards[] | select(.name == $kb) | .active_keymap')

# Map verbose names to short codes
case "$ACTIVE" in
  "Danish")  SHORT="DK" ;;
  "English (US)") SHORT="US" ;;
  *) SHORT="$ACTIVE" ;; # fallback: just show whatever it is
esac

echo "$SHORT"

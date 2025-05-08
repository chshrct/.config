#!/bin/bash

# Get the active window ID and current workspace ID
active_window_info=$(hyprctl activewindow -j)
active_window=$(echo "$active_window_info" | jq -r '.address')
current_workspace=$(echo "$active_window_info" | jq -r '.workspace.id')

# Get all windows in the current workspace only
windows=$(hyprctl clients -j | jq -c --arg ws "$current_workspace" '.[] | select(.workspace.id == ($ws | tonumber))')

# Loop through windows and close all except the active one
echo "$windows" | while read -r window; do
    window_id=$(echo "$window" | jq -r '.address')
    if [ "$window_id" != "$active_window" ]; then
        hyprctl dispatch closewindow "address:$window_id"
    fi
done

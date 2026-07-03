#!/bin/bash

HISTORY_FILE="$HOME/.config/aerospace/workspace-history"

# Get current workspace
current=$(aerospace list-workspaces --focused)

# Read history (most recent first)
if [ -f "$HISTORY_FILE" ]; then
    mapfile -t history < "$HISTORY_FILE"
else
    history=()
fi

# Find the next workspace to switch to
next=""
for ws in "${history[@]}"; do
    if [ "$ws" != "$current" ] && aerospace list-workspaces --monitor focused --empty no | grep -q "^$ws$"; then
        next="$ws"
        break
    fi
done

# If no history or all history exhausted, cycle to prev workspace
if [ -z "$next" ]; then
    workspaces=$(aerospace list-workspaces --monitor focused --empty no)
    next=$(echo "$workspaces" | grep -B1 "^$current$" | head -1)
    if [ "$next" = "$current" ]; then
        next=$(echo "$workspaces" | tail -1)
    fi
fi

# Switch to the workspace
aerospace workspace "$next"

# Update history (keep last 10, with current at the top)
echo "$current" > "$HISTORY_FILE.tmp"
grep -v "^$current$" "$HISTORY_FILE" 2>/dev/null | head -9 >> "$HISTORY_FILE.tmp"
mv "$HISTORY_FILE.tmp" "$HISTORY_FILE"

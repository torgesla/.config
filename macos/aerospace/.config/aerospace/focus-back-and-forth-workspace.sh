#!/bin/bash
# Get current workspace
current_workspace=$(aerospace list-workspaces --focused)

# Get current focused window
current_window=$(aerospace list-windows --focused --format '%{window-id}')

# Get all windows in current workspace, excluding current window
windows=$(aerospace list-windows --workspace "$current_workspace" --format '%{window-id}' | grep -v "^$current_window$")

# Get the most recently focused window (second in dfs order)
previous_window=$(echo "$windows" | head -1)

# Focus the previous window if it exists
if [ -n "$previous_window" ]; then
    aerospace focus --window-id "$previous_window"
fi

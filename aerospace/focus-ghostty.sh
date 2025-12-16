#!/bin/bash
window_id=$(aerospace list-windows --monitor all --app-bundle-id com.mitchellh.ghostty --format '%{window-id}' | head -1)
if [ -n "$window_id" ]; then
    aerospace focus --window-id "$window_id"
fi

#!/usr/bin/env bash

TMUX_FZF_DIR="$HOME/.config/tmux/plugins/tmux-fzf"
source "$TMUX_FZF_DIR/scripts/.envs"

# Function to get icon for session
get_session_icon() {
    case "$1" in
        "b2b-forms") echo "󰈙" ;;
        "b2b-forms-api") echo "󰒲" ;;
        "config") echo "" ;;
        "dp-bht-revenue") echo "󰮯" ;;
        "nettbureau") echo "󰖟" ;;
        "playground") echo "󰙨" ;;
        "portal") echo "󰈻" ;;
        *) echo "" ;;
    esac
}

current_window=$(tmux display-message -p '#S:#I:')

# Get windows sorted by session name, then by window index
windows=$(tmux list-windows -a -F "#S:#I:#{window_name}" | sort -t: -k1,1 -k2,2n)

# Transform windows with icons
formatted_windows=""
while IFS= read -r line; do
    session_name=$(echo "$line" | cut -d: -f1)
    window_index=$(echo "$line" | cut -d: -f2)
    window_name=$(echo "$line" | cut -d: -f3-)
    
    # Get icon for session
    icon=$(get_session_icon "$session_name")
    
    # Format: session:index: icon window_name
    formatted_windows+="$session_name:$window_index: $icon $window_name"$'\n'
done <<< "$windows"

# Remove current window from list
formatted_windows=$(echo "$formatted_windows" | grep -v "^$current_window")

FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --header='Select target window.'"
target_origin=$(printf "%s[cancel]" "$formatted_windows" | eval "$TMUX_FZF_BIN $TMUX_FZF_OPTIONS")

[[ "$target_origin" == "[cancel]" || -z "$target_origin" ]] && exit

# Extract session:index from selection
target=$(echo "$target_origin" | sed 's/: .*//')

echo "$target" | sed 's/:.*//g' | xargs -I{} tmux switch-client -t {}
echo "$target" | xargs -I{} tmux select-window -t {}

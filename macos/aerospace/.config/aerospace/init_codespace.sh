#!/bin/bash

# This script sets up the layout for the "Code" workspace in AeroSpace.
# It launches Chrome and two Ghostty terminals, then arranges them.

# 1. Launch all the required applications.
# We use 'aerospace exec-and-forget' to launch them in the background
# so the script doesn't wait for each app to close.
aerospace exec-and-forget open -a "Google Chrome"
aerospace exec-and-forget ghostty --working-directory /Users/torgeir.laurvik/Code/bedrift.drdropin.no/portal
aerospace exec-and-forget ghostty --working-directory /Users/torgeir.laurvik/Code/bedrift.drdropin.no/portal

# 2. Wait briefly for the windows to be created and tiled by AeroSpace.
# On slower systems, you might need to increase this value slightly (e.g., to 'sleep 1').
sleep 0.5

# At this point, the default layout is horizontal: [Chrome] [Ghostty-1] [Ghostty-2]

# 3. Focus the rightmost window (the second, most recently opened Ghostty instance).
aerospace focus last

# 4. Join the focused window (Ghostty-2) with the one to its left (Ghostty-1).
# This action creates a new container holding both terminals.
# The layout becomes: [Chrome] [Container: Ghostty-1, Ghostty-2]
aerospace join-with left

# 5. The newly created container is now automatically focused.
# Change its layout to accordion style.
aerospace layout accordion

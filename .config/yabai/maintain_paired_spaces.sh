#!/usr/bin/env sh
# file: ~/.config/yabai/maintain_paired_spaces.sh

# Keep two displays with spaces [1-5] and [6-12] in sync
#
# yabai signal 'space_changed'
# Passes two arguments $YABAI_SPACE_ID and $YABAI_RECENT_SPACE_ID

# Note $YABAI_SPACE_ID is not the same as the mission control index.
# Translate YABAI_SPACE_ID to mission control index as following
new=$(yabai -m query --spaces | jq ".[] | select(.id == $YABAI_SPACE_ID) | .index")

# modulo arithmetic
other=$(((new+4)%10+1))

# Check if already visible
visible=$(yabai -m query --spaces | jq ".[] | select(.visible == 1 and .index == $other)")
if [ -z "$visible" ]; then
    yabai -m space --focus "${other}"
    display=$(yabai -m query --spaces --space $other | jq ".display")
fi

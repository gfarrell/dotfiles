#!/bin/zsh

# Get all displays
displays=$(xrandr | awk '/ connected/ { printf "%s\n", $1 }');

# Ask user which they want to use
display="$(echo $displays | rofi -dmenu -p 'Move workspace to')"

if [[ -z $display ]]; then
  exit 0;
fi

# Tell i3 to move the workspace
i3-msg "move workspace to output ${display}"

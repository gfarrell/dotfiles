#!/bin/zsh
DIR=$(dirname $0)
CMD=$1

# Get the first bluetooth device info
# This comes as a CSV
BT_SINK=$(pacmd list-cards | $DIR/bt_dev_info.awk | grep "bluez" | head -n 1)

if [ ! -z ${BT_SINK} ]; then
  # if there is a device connected, then we can either list or change profile
  # otherwise we do nothing
  id=$(echo ${BT_SINK} | cut -d "," -f 1)
  current_profile=$(echo ${BT_SINK} | cut -d "," -f 4)
  case ${current_profile} in
    "<a2dp_sink>")
      icon=""
      next_profile="headset_head_unit"
      ;;
    "<headset_head_unit>")
      icon=""
      next_profile="a2dp_sink"
      ;;
    *)
      icon="unknown"
      next_profile=""
      ;;
  esac
  case $CMD in
    "toggle_profile")
      pacmd set-card-profile ${id} ${next_profile}
      ;;
    *)
      echo "${icon} "
      ;;
  esac
else
  echo ""
fi

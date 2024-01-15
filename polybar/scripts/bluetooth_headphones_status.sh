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
      next_profile="handsfree_head_unit"
      ;;
    "<handsfree_head_unit>")
      icon=""
      next_profile="a2dp_sink"
      ;;
    *)
      icon="unknown"
      next_profile=""
      ;;
  esac
  # Read battery as a percentage, upower needs to be installed and
  # experimental bluetooth features need to be enabled, see
  # https://wiki.archlinux.org/title/bluetooth#Enabling_experimental_features
  mac_address=$(echo ${BT_SINK} | cut -d "," -f 5)
  battery=$(upower -d | $DIR/read_battery.awk | grep ${mac_address} | head -n 1 | cut -d "," -f 3 | tr -d "%")
  case $CMD in
    "toggle_profile")
      pacmd set-card-profile ${id} ${next_profile}
      ;;
    *)
      batI=""
      if [ ! -z "$battery" ]; then
        batI=""
        (( $battery > 10 )) && batI=""
        (( $battery > 50 )) && batI=""
        (( $battery > 75 )) && batI=""
        (( $battery > 90 )) && batI=""
      fi
      echo "| ${icon} ${batI} |"
      ;;
  esac
else
  echo ""
fi

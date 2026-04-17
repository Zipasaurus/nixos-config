##!/usr/bin/env bash#
#
#KEYBOARD_NAME="AT Translated Set 2 keyboard"
#TRACKPAD_NAME="MSFT0001:00 06CB:CE2D Touchpad" 
#DEVICE="/dev/input/event20"  # Tablet mode switch#
#
#get_device_id() {
#  local device_name="$1"
#  xinput list | grep "$device_name" | grep -o 'id=[0-9]*' | cut -d= -f2
#}#
#
#keyboard_id=$(get_device_id "$KEYBOARD_NAME")
#trackpad_id=$(get_device_id "$TRACKPAD_NAME")
#
#if [[ -z "$keyboard_id" ]]; then
#  echo "Keyboard not found: $KEYBOARD_NAME"
#  exit 1
#fi#
#
#if [[ -z "$trackpad_id" ]]; then
#  echo "Trackpad not found: $TRACKPAD_NAME"
#  exit 1
#fi
#
#echo "Monitoring tablet mode switch..."
#sudo evtest "$DEVICE" | while read -r line; do
#  if echo "$line" | grep -q "SW_TABLET_MODE"; then
#    if echo "$line" | grep -q "value 1"; then
#      echo "[Tablet Mode] Disabling keyboard and trackpad"
#      xinput disable "$keyboard_id"
#      xinput disable "$trackpad_id"
#    elif echo "$line" | grep -q "value 0"; then
#      echo "[Laptop Mode] Enabling keyboard and trackpad"
#      xinput enable "$keyboard_id"
#      xinput enable "$trackpad_id"
#    fi
#  fi
#done

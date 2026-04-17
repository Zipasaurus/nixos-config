#!/usr/bin/env bash

# Get total and used swap (in MB)
read total used <<<$(free -m | awk '/Swap:/ {print $2, $3}')

if [ "$total" -eq 0 ]; then
  echo "No Swap"
else
  percent=$(( 100 * used / total ))
  echo " ${used}M / ${total}M (${percent}%)"
fi

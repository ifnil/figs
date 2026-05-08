#!/usr/bin/env bash
# Echo "1" if a battery is present, empty string otherwise.
# Used by tmux.conf to hide battery status on desktops.

case "$(uname -s)" in
  Linux)
    for bat in /sys/class/power_supply/BAT*; do
      [[ -e "$bat" ]] && { echo 1; exit 0; }
    done
    ;;
  Darwin)
    pmset -g batt 2>/dev/null | grep -q InternalBattery && { echo 1; exit 0; }
    ;;
esac

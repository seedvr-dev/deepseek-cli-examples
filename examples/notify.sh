#!/usr/bin/env bash
# A Deep Code notify script. The integration page says notify is a path to a
# script executed after each model turn, and nothing about the arguments or
# environment it receives - so this script logs whatever it gets.
#
# Add to ~/.deepcode/settings.json:
#   "notify": "/absolute/path/to/examples/notify.sh"
#
# Then inspect ~/.deepcode/notify.log after a turn.
set -u

LOG="$HOME/.deepcode/notify.log"
mkdir -p "$(dirname "$LOG")"

# Terminal bell: most terminals flash or ding, which is enough to bring you back.
printf '\a'

{
  printf '%s turn finished' "$(date '+%Y-%m-%dT%H:%M:%S')"
  if [ "$#" -gt 0 ]; then
    printf ' args:'
    for a in "$@"; do printf ' %q' "$a"; done
  fi
  printf '\n'
} >> "$LOG"

# Replace the bell with a desktop notification once you know what is passed,
# e.g. notify-send on Linux or osascript on macOS.
exit 0

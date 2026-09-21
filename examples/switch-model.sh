#!/usr/bin/env bash
# Switch env.MODEL in ~/.deepcode/settings.json between the two documented models.
#
#   bash examples/switch-model.sh flash   -> deepseek-v4-flash
#   bash examples/switch-model.sh pro     -> deepseek-v4-pro
#   bash examples/switch-model.sh         -> toggle
#
# Only env.MODEL is rewritten; every other key is preserved.
set -euo pipefail

FILE="$HOME/.deepcode/settings.json"
if [ ! -f "$FILE" ]; then
  echo "$FILE not found - run examples/setup-settings.sh first" >&2
  exit 1
fi

TARGET="${1:-}"
case "$TARGET" in
  flash) WANT='deepseek-v4-flash' ;;
  pro)   WANT='deepseek-v4-pro' ;;
  '')    WANT='' ;;
  *) echo 'usage: switch-model.sh [flash|pro]' >&2; exit 1 ;;
esac

WANT="$WANT" FILE="$FILE" node -e '
  const fs = require("fs");
  const file = process.env.FILE;
  const s = JSON.parse(fs.readFileSync(file, "utf8"));
  s.env = s.env || {};
  const current = s.env.MODEL || "deepseek-v4-pro";
  let next = process.env.WANT;
  if (!next) {
    next = current === "deepseek-v4-pro" ? "deepseek-v4-flash" : "deepseek-v4-pro";
  }
  s.env.MODEL = next;
  fs.writeFileSync(file, JSON.stringify(s, null, 2) + "\n");
  console.log(current + " -> " + next);
'
echo 'restart deepcode or use /new for the change to apply'

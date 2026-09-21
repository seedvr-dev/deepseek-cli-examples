#!/usr/bin/env bash
# Write ~/.deepcode/settings.json for Deep Code from environment variables.
#
# Required:  DEEPSEEK_API_KEY   (from the API keys page on the DeepSeek Platform)
# Optional:  DEEPSEEK_MODEL     deepseek-v4-pro (default) or deepseek-v4-flash
#            DEEPSEEK_BASE_URL  defaults to https://api.deepseek.com, as documented
#            DEEPSEEK_EFFORT    reasoningEffort: high (default) or max
#
# The keys written here are exactly the ones the integration page documents.
set -euo pipefail

if [ -z "${DEEPSEEK_API_KEY:-}" ]; then
  echo 'DEEPSEEK_API_KEY is not set' >&2
  exit 1
fi

MODEL="${DEEPSEEK_MODEL:-deepseek-v4-pro}"
BASE_URL="${DEEPSEEK_BASE_URL:-https://api.deepseek.com}"
EFFORT="${DEEPSEEK_EFFORT:-high}"

case "$EFFORT" in
  high|max) ;;
  *) echo "DEEPSEEK_EFFORT must be high or max, got: $EFFORT" >&2; exit 1 ;;
esac

DIR="$HOME/.deepcode"
FILE="$DIR/settings.json"
mkdir -p "$DIR"

# node is already present because the CLI is an npm package; use it to emit valid JSON.
MODEL="$MODEL" BASE_URL="$BASE_URL" EFFORT="$EFFORT" node -e '
  const s = {
    env: {
      MODEL: process.env.MODEL,
      BASE_URL: process.env.BASE_URL,
      API_KEY: process.env.DEEPSEEK_API_KEY,
    },
    thinkingEnabled: true,
    reasoningEffort: process.env.EFFORT,
  };
  process.stdout.write(JSON.stringify(s, null, 2) + "\n");
' > "$FILE"

chmod 600 "$FILE"
echo "wrote $FILE (model=$MODEL, reasoningEffort=$EFFORT)"

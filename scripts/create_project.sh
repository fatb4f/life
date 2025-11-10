#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

TITLE="${PROJECT_TITLE:-Operations Board}"

echo "==> Ensuring project exists: $TITLE"
# Find existing
row=$(gh project list --owner "$OWNER" --format json | jq -c '.[] | select(.title=="'"$TITLE"'")' || true)
if [[ -z "$row" || "$row" == "null" ]]; then
  out=$(gh project create --owner "$OWNER" --title "$TITLE" --format json)
else
  out="$row"
fi

PID=$(jq -r '.id' <<<"$out")
PNUM=$(jq -r '.number' <<<"$out")

echo "$PID"  > "$ROOT_DIR/.project_id"
echo "$PNUM" > "$ROOT_DIR/.project_number"

echo "Project ready (id=$PID, number=$PNUM) ✅"

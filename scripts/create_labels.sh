#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

SEEDS="$ROOT_DIR/seeds/labels.tsv"

echo "==> Syncing labels from $SEEDS"
while IFS=$'\t' read -r NAME COLOR DESC; do
  [[ -z "$NAME" || "$NAME" == \#* ]] && continue
  COLOR="${COLOR#\#}" # strip leading '#'
  if gh label list -R "$OWNER/$REPO" --search "$NAME" --limit 100 | grep -q "^$NAME\b"; then
    gh label edit "$NAME" -R "$OWNER/$REPO" --color "$COLOR" --description "$DESC"
    echo "Updated label: $NAME"
  else
    gh label create "$NAME" -R "$OWNER/$REPO" --color "$COLOR" --description "$DESC" || true
    echo "Created label: $NAME"
  fi
done < "$SEEDS"
echo "Labels synced ✅"

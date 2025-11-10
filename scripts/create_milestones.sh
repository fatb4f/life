#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

SEEDS="$ROOT_DIR/seeds/milestones.csv"
API="$(repo_api)/milestones"

echo "==> Syncing milestones from $SEEDS"
# Skip header row; parse CSV as: title, due_on, description
tail -n +2 "$SEEDS" | while IFS=',' read -r TITLE DUE_ON DESC; do
  # Normalize title & skip empty
  TITLE_TRIM="$(echo "$TITLE" | xargs)"
  [[ -z "$TITLE_TRIM" ]] && continue

  # Normalize date-only to RFC3339 (UTC midnight) if provided as YYYY-MM-DD
  if [[ -n "${DUE_ON:-}" ]]; then
    if [[ "$DUE_ON" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
      DUE_ON="${DUE_ON}T00:00:00Z"
    fi
  fi

  # Does milestone already exist?
  MID="$(gh api "$API" --paginate --jq \
    '.[] | select(.title=="'"$TITLE_TRIM"'") | .number' 2>/dev/null | head -n1 || true)"

  if [[ -n "$MID" ]]; then
    echo "Exists: $TITLE_TRIM (#$MID)"
    # NOTE: Editing due_on/description is omitted for simplicity.
  else
    args=( -X POST "$API" -f "title=$TITLE_TRIM" -f state=open )
    [[ -n "${DUE_ON:-}" ]] && args+=( -f "due_on=$DUE_ON" )
    [[ -n "${DESC:-}"   ]] && args+=( -f "description=$DESC" )

    gh api "${args[@]}" >/dev/null
    echo "Created: $TITLE_TRIM"
  fi
done

echo "Milestones synced ✅"

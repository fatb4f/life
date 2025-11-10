#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

SEEDS="$ROOT_DIR/seeds/issues.csv"

echo "==> Creating seed issues from $SEEDS"

# Use Python's csv module to parse correctly, then read TSV in bash
python3 - "$SEEDS" <<'PY' | while IFS=$'\t' read -r TITLE BODY_PATH LABELS MILESTONE; do
import csv, sys
path = sys.argv[1]
with open(path, newline='', encoding='utf-8') as f:
    r = csv.DictReader(f)
    for row in r:
        title = (row.get('title') or '').strip()
        body  = (row.get('body_path') or '').strip()
        labels= (row.get('labels') or '').strip()
        mile  = (row.get('milestone') or '').strip()
        if not title:
            continue
        print('\t'.join([title, body, labels, mile]))
PY
  # Skip if an open issue with the exact same title exists
  if gh issue list -R "$OWNER/$REPO" --limit 1000 --json title,state \
      --jq '.[] | select(.title=="'"$TITLE"'") | select(.state=="OPEN")' | grep -q .; then
    echo "Skip (exists): $TITLE"
    continue
  fi

  ARGS=(-R "$OWNER/$REPO" --title "$TITLE")

  # Body file (optional)
  if [[ -n "$BODY_PATH" && -f "$ROOT_DIR/$BODY_PATH" ]]; then
    ARGS+=(--body-file "$ROOT_DIR/$BODY_PATH")
  fi

  # Labels: split on commas into multiple --label flags
  if [[ -n "$LABELS" ]]; then
    IFS=',' read -ra LARR <<< "$LABELS"
    for L in "${LARR[@]}"; do
      LTRIM="$(echo "$L" | xargs)"
      [[ -n "$LTRIM" ]] && ARGS+=(--label "$LTRIM")
    done
  fi

  # Milestone: resolve by title to number
  if [[ -n "$MILESTONE" ]]; then
    MID="$(gh api "repos/${OWNER}/${REPO}/milestones" --jq \
      '.[] | select(.title=="'"$MILESTONE"'") | .number' | head -n1 || true)"
    [[ -n "$MID" ]] && ARGS+=(--milestone "$MID")
  fi

  gh issue create "${ARGS[@]}" >/dev/null
  echo "Created: $TITLE"
done

echo "Seed issues created ✅"

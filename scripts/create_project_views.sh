#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$SCRIPT_DIR/common.sh"

# Prefer number when talking to `gh project view`
if [[ -f "$ROOT_DIR/.project_number" ]]; then
  PNUM="$(cat "$ROOT_DIR/.project_number")"
else
  echo "No .project_number found. Please run: echo <NUMBER> > .project_number"
  exit 1
fi

echo "==> Syncing views for project #$PNUM"

# Verify project exists and show any current views (if JSON supported)
if gh project view "$PNUM" --format json >/dev/null 2>&1; then
  existing="$(gh project view "$PNUM" --format json | jq -r '.views[]?.name' 2>/dev/null || true)"
  echo "Current views:"
  [[ -n "$existing" ]] && echo "$existing" || echo "(none reported)"
else
  echo "Note: your gh build may not support JSON views output. Proceeding with best-effort."
fi

# Try to detect a 'view-create' subcommand (not available in most gh builds)
if gh help project 2>/dev/null | grep -q 'view-create'; then
  # If your gh supports this (rare), create simple views
  # Board "Board" (is:open), Table "Table" (is:open), Board "By Label" (is:open sort:label)
  gh project view-create "$PNUM" --name "Board" --type BOARD --filter "is:open" || true
  gh project view-create "$PNUM" --name "Table" --type TABLE --filter "is:open" || true
  gh project view-create "$PNUM" --name "By Label" --type BOARD --filter "is:open sort:label" || true
  echo "Views created (where supported) ✅"
else
  cat <<EOF
Your gh CLI doesn't expose a 'view-create' command.
Open the project in your browser and add these suggested views:

1) Board — filter: is:open
2) Table — filter: is:open
3) By Label — layout: Board, filter: is:open sort:label

Tip: You can still use the rest of the automation. Views are purely visual presets.
EOF
fi

echo "Views step complete ✅"

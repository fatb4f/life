#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

WEEK_DIR="$ROOT_DIR/seeds/weeks"
TEMPLATE="$WEEK_DIR/week-template.md"

mkdir -p "$WEEK_DIR"

# Ensure template exists
if [[ ! -f "$TEMPLATE" ]]; then
  cat > "$TEMPLATE" <<'EOF'
# Week N Sprint
- Goals:
- Must-do:
- Nice-to-have:

## Tasks
- [ ] Example task

## Notes
- ...
EOF
fi

# Find current max week number
shopt -s nullglob
max=0
for f in "$WEEK_DIR"/week-*.md; do
  base="${f##*/}"                # week-12.md
  num="${base//[!0-9]/}"         # 12
  [[ -n "$num" ]] && (( num > max )) && max="$num"
done

next=$(( max + 1 ))
out="$WEEK_DIR/week-$next.md"

cp "$TEMPLATE" "$out"
echo "Created $out"

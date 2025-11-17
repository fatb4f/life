#!/usr/bin/env bash
set -euo pipefail

if ! command -v gh >/dev/null; then
  echo "Please install GitHub CLI: https://cli.github.com/"
  exit 1
fi

OWNER="$(gh api user --jq .login 2>/dev/null || true)"
REPO="$(basename "$PWD")"
PUBLIC="${PUBLIC:-}"

make OWNER="${OWNER}" REPO="${REPO}" $( [ -n "$PUBLIC" ] && echo "PUBLIC=1" ) all

echo "Done. Repo: https://github.com/${OWNER}/${REPO}"

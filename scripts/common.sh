#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
source "$ROOT_DIR/config/repo.env"

# Assert gh+jq
command -v gh >/dev/null || { echo "Missing gh CLI"; exit 1; }
command -v jq >/dev/null || { echo "Missing jq"; exit 1; }

# Utility: repo API path
repo_api() {
  echo "repos/${OWNER}/${REPO}"
}

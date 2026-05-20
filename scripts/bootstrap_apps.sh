#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APPS_DIR="$ROOT_DIR/apps"

mkdir -p "$APPS_DIR"

clone_or_update() {
  local repo_url="$1"
  local target_dir="$2"

  if [ -d "$target_dir/.git" ]; then
    echo "[update] $target_dir"
    git -C "$target_dir" pull --ff-only
  elif [ -d "$target_dir" ]; then
    echo "[skip] $target_dir exists but is not a git repo"
  else
    echo "[clone] $repo_url -> $target_dir"
    git clone "$repo_url" "$target_dir"
  fi
}

clone_or_update "https://github.com/zetsudan/zr_plus-spectrum-calculator" "$APPS_DIR/zr_plus-spectrum-calculator"
clone_or_update "https://github.com/zetsudan/optical-circuit-merger" "$APPS_DIR/optical-circuit-merger"
clone_or_update "https://github.com/zetsudan/oel_merger" "$APPS_DIR/oel_merger"
clone_or_update "https://github.com/zetsudan/pw_planner" "$APPS_DIR/pw_planner"

echo "Done."

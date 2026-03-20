#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <codex|claude|all> <target-project-path>"
  exit 1
fi

MODE="$1"
TARGET="$2"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

mkdir -p "$TARGET"

copy_common() {
  mkdir -p "$TARGET/.agent-core"
  rsync -a "$ROOT_DIR/.agent-core/" "$TARGET/.agent-core/"
}

copy_codex() {
  mkdir -p "$TARGET/.codex"
  rsync -a "$ROOT_DIR/.codex/" "$TARGET/.codex/"
}

copy_claude() {
  mkdir -p "$TARGET/.claude"
  rsync -a "$ROOT_DIR/.claude/" "$TARGET/.claude/"
}

copy_common

case "$MODE" in
  codex)
    copy_codex
    ;;
  claude)
    copy_claude
    ;;
  all)
    copy_codex
    copy_claude
    ;;
  *)
    echo "Invalid mode: $MODE"
    exit 1
    ;;
esac

echo "[done] bootstrapped '$MODE' configs into $TARGET"

#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: bootstrap.sh [--copy|--link] [--dry-run] [--force] <codex|claude|all> <target-project-path>

Modes:
  --copy     Copy files into the target project. This is the default.
  --link     Create symlinks back to this repository so updates stay centralized.

Safety:
  --dry-run  Print what would happen without changing the target.
  --force    Replace an existing file, directory, or symlink at the destination.

Examples:
  ./scripts/bootstrap.sh all /path/to/project
  ./scripts/bootstrap.sh --link codex /path/to/project
  ./scripts/bootstrap.sh --dry-run --link all /path/to/project
USAGE
}

INSTALL_MODE="copy"
DRY_RUN=0
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --copy)
      INSTALL_MODE="copy"
      shift
      ;;
    --link|--symlink)
      INSTALL_MODE="link"
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --force)
      FORCE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage
      exit 1
      ;;
    *)
      break
      ;;
  esac
done

if [[ $# -lt 2 ]]; then
  usage
  exit 1
fi

MODE="$1"
TARGET="$2"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf '[dry-run] %q' "$1"
    shift
    for arg in "$@"; do
      printf ' %q' "$arg"
    done
    printf '\n'
  else
    "$@"
  fi
}

ensure_target() {
  run mkdir -p "$TARGET"
}

copy_dir() {
  local source="$1"
  local dest="$2"
  run mkdir -p "$dest"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    run rsync -a --dry-run "$source/" "$dest/"
  else
    rsync -a "$source/" "$dest/"
  fi
}

link_dir() {
  local source="$1"
  local dest="$2"
  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ "$FORCE" -ne 1 ]]; then
      echo "Destination already exists: $dest" >&2
      echo "Use --force to replace it, or use --copy to merge files." >&2
      exit 1
    fi
    run rm -rf "$dest"
  fi
  run mkdir -p "$(dirname "$dest")"
  run ln -s "$source" "$dest"
}

install_dir() {
  local name="$1"
  local source="$ROOT_DIR/$name"
  local dest="$TARGET/$name"
  if [[ "$INSTALL_MODE" == "link" ]]; then
    link_dir "$source" "$dest"
  else
    copy_dir "$source" "$dest"
  fi
}

install_common() {
  install_dir ".agent-core"
}

install_codex() {
  install_dir ".codex"
}

install_claude() {
  install_dir ".claude"
}

ensure_target
install_common

case "$MODE" in
  codex)
    install_codex
    ;;
  claude)
    install_claude
    ;;
  all)
    install_codex
    install_claude
    ;;
  *)
    echo "Invalid mode: $MODE" >&2
    usage
    exit 1
    ;;
esac

echo "[done] bootstrapped '$MODE' configs into $TARGET using $INSTALL_MODE mode"

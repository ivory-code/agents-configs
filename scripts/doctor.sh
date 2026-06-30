#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <target-project-path>"
  exit 1
fi

TARGET="$1"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
STATUS=0

check_path() {
  local name="$1"
  local required="${2:-0}"
  local expected="$ROOT_DIR/$name"
  local actual="$TARGET/$name"

  if [[ ! -e "$actual" && ! -L "$actual" ]]; then
    if [[ "$required" -eq 1 ]]; then
      echo "[missing] $name"
      STATUS=1
    else
      echo "[absent]  $name"
    fi
    return
  fi

  if [[ -L "$actual" ]]; then
    local link_target
    local resolved
    link_target="$(readlink "$actual")"
    if [[ "$link_target" = /* ]]; then
      resolved="$link_target"
    else
      resolved="$(cd "$(dirname "$actual")" && pwd -P)/$link_target"
    fi
    if [[ "$resolved" == "$expected" ]]; then
      echo "[linked]  $name -> $expected"
    else
      echo "[linked]  $name -> $link_target"
      echo "          expected source: $expected"
      STATUS=1
    fi
    return
  fi

  if [[ -d "$actual" ]]; then
    echo "[copied]  $name"
    return
  fi

  echo "[invalid] $name exists but is not a directory or symlink"
  STATUS=1
}

echo "# agents-configs doctor"
echo "target: $TARGET"
echo "source: $ROOT_DIR"
echo

check_path ".agent-core" 1
check_path ".codex" 0
check_path ".claude" 0

echo
if [[ "$STATUS" -eq 0 ]]; then
  echo "[ok] agent config installation looks usable"
else
  echo "[warn] agent config installation needs attention"
fi

exit "$STATUS"

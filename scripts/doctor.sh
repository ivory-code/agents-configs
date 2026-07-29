#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <target-project-path> [auto|codex|claude|all]"
  exit 1
fi

TARGET="$1"
MODE="${2:-auto}"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
STATUS=0

case "$MODE" in
  auto|codex|claude|all)
    ;;
  *)
    echo "Invalid mode: $MODE" >&2
    echo "Usage: $0 <target-project-path> [auto|codex|claude|all]" >&2
    exit 1
    ;;
esac

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
    elif [[ "$required" -eq 0 ]]; then
      echo "[external] $name -> $link_target"
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
echo "mode: $MODE"
echo

check_path ".agent-core" 1
check_path ".agents" 1

case "$MODE" in
  codex)
    check_path ".codex" 1
    check_path ".claude" 0
    ;;
  claude)
    check_path ".codex" 0
    check_path ".claude" 1
    ;;
  all)
    check_path ".codex" 1
    check_path ".claude" 1
    ;;
  auto)
    check_path ".codex" 0
    check_path ".claude" 0
    ;;
esac

R2C_SKILL_PATH="$TARGET/.agents/skills/risk-to-confidence/SKILL.md"
if [[ -f "$R2C_SKILL_PATH" ]]; then
  echo "[skill]   risk-to-confidence via .agents"
else
  echo "[missing] risk-to-confidence discovery path"
  STATUS=1
fi

CLAUDE_R2C_SKILL_PATH="$TARGET/.claude/skills/risk-to-confidence/SKILL.md"
if [[ -f "$CLAUDE_R2C_SKILL_PATH" ]]; then
  echo "[skill]   risk-to-confidence via .claude"
elif [[ "$MODE" == "claude" || "$MODE" == "all" ]]; then
  echo "[missing] risk-to-confidence Claude discovery path"
  STATUS=1
elif [[ "$MODE" == "auto" && ( -e "$TARGET/.claude" || -L "$TARGET/.claude" ) ]]; then
  echo "[info]    .claude exists without the optional risk-to-confidence adapter"
fi

echo
if [[ "$STATUS" -eq 0 ]]; then
  echo "[ok] agent config installation looks usable"
else
  echo "[warn] agent config installation needs attention"
fi

exit "$STATUS"

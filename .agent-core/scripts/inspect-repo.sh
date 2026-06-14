#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-$(pwd)}"
cd "$ROOT"

echo "# Agent Repo Context"
echo "cwd: $(pwd)"

if [[ -f pnpm-lock.yaml ]]; then pm="pnpm";
elif [[ -f yarn.lock ]]; then pm="yarn";
elif [[ -f package-lock.json ]]; then pm="npm";
elif [[ -f bun.lockb || -f bun.lock ]]; then pm="bun";
else pm="unknown"; fi

echo "package_manager: $pm"

node <<'NODE'
const fs = require('fs');
const path = require('path');
const readJson = (file) => {
  try { return JSON.parse(fs.readFileSync(file, 'utf8')); } catch { return null; }
};
const pkg = readJson('package.json') || {};
const deps = { ...(pkg.dependencies || {}), ...(pkg.devDependencies || {}) };
const has = (name) => Object.prototype.hasOwnProperty.call(deps, name);
const scripts = pkg.scripts || {};
const frameworks = [];
if (has('expo') || has('react-native')) frameworks.push('react-native/expo');
if (has('next')) frameworks.push('next');
if (has('nuxt')) frameworks.push('nuxt');
if (has('vue')) frameworks.push('vue');
if (has('react')) frameworks.push('react');
if (has('vite')) frameworks.push('vite');
const state = [];
if (has('@tanstack/react-query')) state.push('tanstack-query');
if (has('react-query')) state.push('react-query-v3');
if (has('redux') || has('@reduxjs/toolkit')) state.push('redux');
if (has('zustand')) state.push('zustand');
if (has('jotai')) state.push('jotai');
const tests = [];
for (const name of ['vitest','jest','@testing-library/react','@testing-library/react-native','playwright','cypress']) {
  if (has(name)) tests.push(name);
}
console.log(`package_name: ${pkg.name || 'unknown'}`);
console.log(`frameworks: ${frameworks.join(', ') || 'unknown'}`);
console.log(`state_data: ${state.join(', ') || 'unknown'}`);
console.log(`test_tools: ${tests.join(', ') || 'unknown'}`);
console.log('scripts:');
for (const key of ['dev','start','lint','typecheck','test','build','ios','android']) {
  if (scripts[key]) console.log(`  ${key}: ${scripts[key]}`);
}
const tsconfig = readJson('tsconfig.json') || {};
const paths = tsconfig.compilerOptions && tsconfig.compilerOptions.paths;
if (paths) {
  console.log('tsconfig_paths:');
  for (const [alias, target] of Object.entries(paths)) {
    console.log(`  ${alias}: ${Array.isArray(target) ? target.join(', ') : target}`);
  }
}
NODE

echo "key_files:"
for f in AGENTS.md CLAUDE.md README.md package.json tsconfig.json eslint.config.js .eslintrc .prettierrc app.json app.config.js; do
  [[ -e "$f" ]] && echo "  $f"
done

echo "top_level_dirs:"
find . -maxdepth 1 -type d \
  ! -name . \
  ! -name .git \
  ! -name node_modules \
  ! -name ios \
  ! -name android \
  | sed 's#^./#  #' | sort | head -40

echo "convention_clues:"
find . -maxdepth 5 -type f \
  \( -iname '*theme*' -o -iname '*token*' -o -iname '*style*' -o -iname '*config*' -o -iname '*test*' -o -iname '*spec*' \) \
  ! -path './node_modules/*' \
  ! -path './.git/*' \
  ! -path './.agents/*' \
  ! -path './.claude/skills/*' \
  ! -path './.expo/*' \
  ! -path './ios/*' \
  ! -path './android/*' \
  | sed 's#^./#  #' | sort | head -80

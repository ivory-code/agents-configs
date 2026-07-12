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
elif [[ -f uv.lock ]]; then pm="uv";
elif [[ -f poetry.lock ]]; then pm="poetry";
elif [[ -f Pipfile.lock ]]; then pm="pipenv";
elif [[ -f pyproject.toml || -f requirements.txt ]]; then pm="python";
elif [[ -f Cargo.lock || -f Cargo.toml ]]; then pm="cargo";
elif [[ -f go.mod ]]; then pm="go";
elif [[ -f gradlew || -f build.gradle || -f build.gradle.kts ]]; then pm="gradle";
elif [[ -f mvnw || -f pom.xml ]]; then pm="maven";
else pm="unknown"; fi

echo "package_manager: $pm"

if command -v node >/dev/null 2>&1; then
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
if (has('@sveltejs/kit')) frameworks.push('sveltekit');
else if (has('svelte')) frameworks.push('svelte');
if (has('react')) frameworks.push('react');
if (has('vite')) frameworks.push('vite');
const state = [];
if (has('@tanstack/react-query')) state.push('tanstack-query');
if (has('react-query')) state.push('react-query-v3');
if (has('redux') || has('@reduxjs/toolkit')) state.push('redux');
if (has('zustand')) state.push('zustand');
if (has('jotai')) state.push('jotai');
const tests = [];
for (const name of ['vitest','jest','@testing-library/react','@testing-library/react-native','@playwright/test','playwright','cypress']) {
  if (has(name)) tests.push(name);
}
console.log(`package_name: ${pkg.name || 'unknown'}`);
console.log(`frameworks: ${frameworks.join(', ') || 'unknown'}`);
console.log(`state_data: ${state.join(', ') || 'unknown'}`);
console.log(`test_tools: ${tests.join(', ') || 'unknown'}`);
console.log('scripts:');
for (const key of ['dev','start','lint','typecheck','check','test','test:e2e','e2e','coverage','verify','build','ci','ios','android']) {
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
else
  echo "package_name: unavailable (node not installed)"
  echo "frameworks: unknown"
  echo "state_data: unknown"
  echo "test_tools: unknown"
  echo "scripts:"
fi

echo "git_context:"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  current_branch="$(git branch --show-current 2>/dev/null || true)"
  [[ -n "$current_branch" ]] || current_branch="detached"

  default_ref="$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null || true)"
  if [[ -z "$default_ref" ]]; then
    for candidate in origin/main main origin/master master; do
      if git rev-parse --verify --quiet "${candidate}^{commit}" >/dev/null; then
        default_ref="$candidate"
        break
      fi
    done
  fi

  echo "  current_branch: $current_branch"
  echo "  default_ref: ${default_ref:-unknown}"
  echo "  branch_commits:"
  if [[ -n "$default_ref" ]] && git merge-base "$default_ref" HEAD >/dev/null 2>&1; then
    if [[ "$(git rev-list --count "$default_ref..HEAD")" -gt 0 ]]; then
      git log --format='    %h %s' "$default_ref..HEAD" | sed -n '1,12p'
    else
      echo "    none"
    fi
  else
    echo "    unavailable"
  fi

  echo "  branch_changed_files:"
  if [[ -n "$default_ref" ]] && git merge-base "$default_ref" HEAD >/dev/null 2>&1; then
    if git diff --quiet "$default_ref...HEAD"; then
      echo "    none"
    else
      git diff --name-status "$default_ref...HEAD" | sed 's/^/    /' | sed -n '1,40p'
    fi
  else
    echo "    unavailable"
  fi

  echo "  working_tree_changes:"
  if [[ -n "$(git status --short)" ]]; then
    git status --short | sed 's/^/    /' | sed -n '1,40p'
  else
    echo "    none"
  fi
else
  echo "  unavailable"
fi

echo "key_files:"
for f in AGENTS.md CLAUDE.md GEMINI.md README.md package.json tsconfig.json eslint.config.js .eslintrc .prettierrc app.json app.config.js pyproject.toml requirements.txt go.mod Cargo.toml build.gradle build.gradle.kts pom.xml .agent-profile.md docs/AGENT_PROFILE.md docs/VERIFICATION_BASELINE.md .github/copilot-instructions.md; do
  [[ -e "$f" ]] && echo "  $f"
done

echo "instruction_surfaces:"
find . -maxdepth 6 \
  \( -path './.git' -o -path './node_modules' -o -path './.venv' -o -path './venv' \
     -o -path './dist' -o -path './build' -o -path './out' -o -path './coverage' \
     -o -path './target' -o -path './.next' -o -path './.nuxt' -o -path './.output' \
     -o -path './.svelte-kit' -o -path './.gradle' -o -path './.expo' \
     -o -path './ios' -o -path './android' -o -path './Pods' -o -path './DerivedData' \
     -o -path '*/fixtures' -o -path '*/benchmarks' \) -prune -o \
  -type f \
  \( -name 'AGENTS.md' -o -name 'CLAUDE.md' -o -name 'GEMINI.md' -o -name 'SKILL.md' \
     -o -name '.clinerules' -o -name '.windsurfrules' \
     -o -path './.cursor/rules/*' -o -path './.roo/rules/*' \
     -o -path './.github/copilot-instructions.md' -o -path './.github/instructions/*' \
     -o -path './.agent-core/skills/*.md' \) \
  -print \
  | sed 's#^./#  #' | sort | sed -n '1,80p'

echo "verification_memory:"
find . -maxdepth 6 \
  \( -path './.git' -o -path './node_modules' -o -path './.venv' -o -path './venv' \
     -o -path './dist' -o -path './build' -o -path './out' -o -path './coverage' \
     -o -path './target' -o -path './.next' -o -path './.nuxt' -o -path './.output' \
     -o -path './.svelte-kit' -o -path './.gradle' -o -path './.expo' \
     -o -path './ios' -o -path './android' -o -path './Pods' -o -path './DerivedData' \
     -o -path '*/fixtures' -o -path '*/benchmarks' \) -prune -o \
  -type f \
  \( -iname '*verification*baseline*.md' -o -iname '*verification*manifest*.yml' \
     -o -iname '*verification*manifest*.yaml' -o -iname '*qa*manifest*.yml' \
     -o -iname '*qa*manifest*.yaml' -o -iname '*test*strategy*.md' \
     -o -iname '*behavior*contract*.md' -o -iname '*agent*profile*.md' \
     -o -iname 'testing.md' -o -iname 'qa.md' -o -iname 'verification.md' \
     -o -iname '*runbook*.md' -o -iname '*playbook*.md' \) \
  -print \
  | sed 's#^./#  #' | sort | sed -n '1,80p'

echo "top_level_dirs:"
find . -maxdepth 1 -type d \
  ! -name . \
  ! -name .git \
  ! -name node_modules \
  ! -name dist \
  ! -name build \
  ! -name out \
  ! -name coverage \
  ! -name target \
  ! -name .next \
  ! -name .nuxt \
  ! -name .output \
  ! -name .svelte-kit \
  ! -name .venv \
  ! -name venv \
  ! -name ios \
  ! -name android \
  | sed 's#^./#  #' | sort | sed -n '1,40p'

echo "convention_clues:"
find . -maxdepth 5 \
  \( -path './.git' -o -path './node_modules' -o -path './.venv' -o -path './venv' \
     -o -path './dist' -o -path './build' -o -path './out' -o -path './coverage' \
     -o -path './target' -o -path './.next' -o -path './.nuxt' -o -path './.output' \
     -o -path './.svelte-kit' -o -path './.gradle' -o -path './.expo' \
     -o -path './ios' -o -path './android' -o -path './Pods' -o -path './DerivedData' \
     -o -path './.agents' -o -path './.claude/skills' \
     -o -path '*/fixtures' -o -path '*/benchmarks' \) -prune -o \
  -type f \
  \( -iname '*theme*' -o -iname '*token*' -o -iname '*style*' -o -iname '*config*' -o -iname '*test*' -o -iname '*spec*' \) \
  -print \
  | sed 's#^./#  #' | sort | sed -n '1,80p'

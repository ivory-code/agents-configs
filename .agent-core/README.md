# Agent Core

벤더 중립 공통 스킬/프로필 저장소.
특정 회사/서비스/레포 이름 없이 재사용 가능해야 한다.

## Directory

```text
.agent-core/
├── profiles/
└── skills/
```

## Skills

- `project-profile-selector.md`
- `code-style.md`
- `design-system.md`
- `testing.md`
- `react-best-practice.md`
- `vercel-composite-patterns.md`
- `superpowers-operating-model.md`
- `convention-adoption.md`
- `pressure-scenarios.md`
- `pr-checklist.md`
- `past-mistakes.md`

## Profiles

- `next-pages-rq3-yarn.md`
- `next-pages-rq3-yarn-semicolon.md`
- `next-monorepo-rq5-pnpm.md`
- `nuxt2-context-only.md`
- `template.md`

## Rules

1. 도메인/회사 고유명 금지
2. 하드코딩 토큰/시크릿 금지
3. 프로젝트 특화 내용은 profile로만 분리
4. 코어 스킬은 다른 레포로 복사해도 즉시 동작해야 함

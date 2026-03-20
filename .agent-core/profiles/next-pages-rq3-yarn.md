# Profile: next-pages-rq3-yarn

## Stack Snapshot

- Framework: Next.js (Pages Router)
- State: Jotai + React Query v3 (`react-query`)
- Styling: Emotion + `styled.ts`
- Package manager: Yarn
- Path alias: `@/*`
- Semicolon: `false`

## Commands

```bash
yarn lint
yarn tsc --noEmit
yarn build
```

## Query Rules

- `react-query` import 사용
- query key factory 패턴 유지
- `invalidateQueries`는 좁은 범위 우선

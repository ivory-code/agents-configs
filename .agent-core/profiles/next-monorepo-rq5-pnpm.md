# Profile: next-monorepo-rq5-pnpm

## Stack Snapshot

- Framework: Next.js monorepo (workspace)
- State: TanStack Query v5 (`@tanstack/react-query`)
- Styling: Emotion
- Package manager: pnpm
- Path alias: `~/*`
- Semicolon: `true`

## Commands (root)

```bash
pnpm lint
pnpm build
```

## Commands (service)

```bash
pnpm --filter <service-name> lint
pnpm --filter <service-name> build
```

## Query Rules

- `@tanstack/react-query` import 사용
- hydration은 v5 API 기준
- v3 옵션/패턴 복붙 금지

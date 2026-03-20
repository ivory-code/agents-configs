# Project Profile Selector

세션 시작 시 가장 먼저 실행하는 스킬.
목적은 "공통 규칙 유지 + 레포별 차이 정확 적용".

## Step 1. 후보 프로필 식별

프로젝트 특성을 보고 아래 중 하나를 고른다.

- `next-pages-rq3-yarn`
  - `packageManager: yarn`
  - `react-query` 의존
  - Pages Router 구조
- `next-pages-rq3-yarn-semicolon`
  - 위와 동일하되 세미콜론 스타일이 엄격한 레포
- `next-monorepo-rq5-pnpm`
  - `pnpm-workspace.yaml` 또는 turbo 기반
  - `@tanstack/react-query` 의존
  - 서비스 단위 필터 빌드 사용
- `nuxt2-context-only`
  - Nuxt2/Vue2 레거시
  - 구현보다 플로우/연계성 파악 목적

## Step 2. 차이점 고정

선택한 profile 기준으로 아래를 고정한다.

- 실행 명령어
- alias 규칙
- query 라이브러리 버전
- semicolon 스타일

## Step 3. 선언 후 작업

작업 시작 전에 아래 형식으로 선언한다.

```text
현재 레포: <name>
적용 profile: <file>
명령어: <lint/typecheck/build>
주의사항: <query version / alias>
```

## Step 4. 셀프 검증

1. import에서 query 버전 혼용이 없는가?
2. alias(`@/`, `~/`) 혼용이 없는가?
3. 실행 명령어가 현재 package manager와 일치하는가?

## 금지 사항

- profile 미확정 상태로 코드 작성
- v3/v5 API 혼합
- 익숙한 레포 기준 명령을 다른 레포에 재사용

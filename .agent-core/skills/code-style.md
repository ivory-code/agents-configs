# Code Style (Generic FE)

도메인 중립 프론트엔드 코드 스타일 스킬.
목적은 "읽기 쉬운 구조 + 타입 안정성 + 유지보수성"을 기본값으로 만드는 것.

## 적용 원칙

- 레포별 실행 명령, alias, React Query 버전은 `../profiles/*`를 우선한다.
- 이 스킬은 구현 패턴과 코드 품질 하한선을 정의한다.

## Quick Checklist

아래 8개를 모두 만족하면 기본 컨벤션 통과:

1. `function` + named export
2. 스타일 분리 파일 사용 (`styled.ts` 또는 동등 규칙)
3. import 순서 정렬
4. 네이밍 규칙 준수
5. 신규/수정 라인 `any` 없음
6. query key factory 사용
7. mutation invalidation 범위 최소화
8. 공개 API는 `index.ts`로 노출

## 1) Component Declaration [HIGH]

```ts
interface ProfileCardProps {
  userName: string
  onOpen: () => void
}

export function ProfileCard({ userName, onOpen }: ProfileCardProps) {
  return <S.Container onClick={onOpen}>{userName}</S.Container>
}
```

규칙:

- `function` + named export 기본
- `React.FC` 기본 사용 금지
- `forwardRef`는 실제 ref 전달 요구(포커스, 스크롤, 측정)가 있을 때만 사용

## 2) File Structure [HIGH]

기본 구조:

```text
ProfileCard/
├── index.tsx
├── styled.ts
└── types.ts (선택)
```

권장 크기:

- 컴포넌트: 200줄 이내
- 페이지 섹션: 400줄 이내
- 페이지: 500줄 이내

초과 시 분리 기준:

- 상태가 독립인 영역
- 반복 렌더 블록
- 비즈니스 로직 분기

## 3) Import Order [MEDIUM]

정렬 순서:

1. React/Next 내장
2. 외부 라이브러리
3. 디자인 시스템
4. 내부 절대 경로
5. 상대 경로
6. 타입 import

예시:

```ts
import { useMemo } from 'react'

import { useQuery } from 'react-query'

import { Button } from '@org/ui'

import { formatCurrency } from '@/shared/lib/number'

import { ProfileMeta } from './ProfileMeta'
import * as S from './styled'

import type { UserProfile } from './types'
```

## 4) Naming [MEDIUM]

- 컴포넌트: PascalCase (`ProfileCard`)
- 함수/변수: camelCase (`handleSubmit`)
- 이벤트 핸들러: `handleX`/`onX`
- boolean: `is`/`has`/`should`
- 상수: UPPER_SNAKE_CASE
- 타입 접두사 `I`/`T` 지양

## 5) TypeScript [CRITICAL]

금지:

- 신규/수정 라인 `any`
- `as any`, `as unknown as any`

권장:

- `unknown` + 타입가드
- Zod 사용 시 `z.infer`
- optional(`?`)과 nullable(`| null`) 명확히 구분

예시:

```ts
function toUserProfile(input: unknown): UserProfile | null {
  if (!input || typeof input !== 'object') return null
  const raw = input as { name?: unknown; followerCount?: unknown }

  if (typeof raw.name !== 'string') return null
  if (typeof raw.followerCount !== 'number') return null

  return {
    name: raw.name,
    followerCount: raw.followerCount,
  }
}
```

## 6) Styling [HIGH]

- 디자인 토큰 우선
- 토큰 부재 시 하드코딩 허용
- transient props는 `$` 접두사

```ts
export const SubmitButton = styled.button<{ $disabled: boolean }>`
  opacity: ${({ $disabled }) => ($disabled ? 0.5 : 1)};
`
```

## 7) React Query [CRITICAL]

query key factory 예시:

```ts
export const userKeys = {
  all: ['user'] as const,
  lists: () => [...userKeys.all, 'list'] as const,
  list: (filter: string) => [...userKeys.all, 'list', filter] as const,
  details: () => [...userKeys.all, 'detail'] as const,
  detail: (id: string) => [...userKeys.all, 'detail', id] as const,
}
```

mutation invalidation 규칙:

- 금지: 전체 키 무효화 남발
- 권장: 관련 list/detail만 최소 범위 무효화

## 8) Public API (Barrel) [MEDIUM]

```ts
// features/profile/components/index.ts
export { ProfileCard } from './ProfileCard'
export { ProfileHeader } from './ProfileHeader'
```

## Review Fail Patterns

아래 항목은 리뷰에서 즉시 수정 대상:

- `any`로 타입 우회
- 컴포넌트 파일 내부에 대량 styled 선언
- query key 문자열 하드코딩
- 페이지에서 비즈니스 로직, API 호출, 렌더링이 한 파일에 과도하게 혼재

## Done Criteria

- 타입 체크 통과
- lint 통과
- profile 기반 빌드 통과
- PR 설명에 변경 범위/리스크/후속 작업 명시

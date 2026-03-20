# Design System Usage (Generic)

디자인 시스템 적용 스킬.
목적은 "컴포넌트/토큰 사용 일관성"과 "UI 회귀 감소".

## Decision Order

```text
org design-system package > legacy ui package > custom component
```

항상 위 순서로 탐색한다.

## 1) Component Selection [CRITICAL]

선택 절차:

1. 조직 디자인 시스템에서 동일 역할 컴포넌트 확인
2. 없으면 레거시 UI 컴포넌트 확인
3. 둘 다 없으면 커스텀 컴포넌트 작성

금지:

- 공통 컴포넌트가 있는데도 네이티브 요소 재구현
- 컴포넌트 API를 깨는 과도한 오버라이드

## 2) Token Priority [HIGH]

```text
design tokens > legacy constants > hardcoded value
```

규칙:

- spacing, color, typography, radius, shadow는 토큰 우선
- 토큰 부재 시 하드코딩 가능
- 하드코딩 시 TODO로 토큰 후보 기록

예시:

```ts
const cardStyle = {
  padding: tokens.spacing[4],
  borderRadius: tokens.radius.md,
  color: tokens.color.text.primary,
}
```

## 3) Typography/Spacing [HIGH]

- 본문/헤딩은 시스템 타이포 컴포넌트 우선
- 간격은 4 또는 8 배수 스케일을 유지
- 페이지 단위 임의 폰트 사이즈/라인하이트 하드코딩 최소화

## 4) Responsive Rules [MEDIUM]

- breakpoint는 프로젝트 상수 사용
- media query 값 하드코딩 지양
- 모바일/데스크톱 분기는 동일 컴포넌트 내 조건 분기보다 레이아웃 계층 분리를 우선 검토

## 5) Adapter Strategy [MEDIUM]

신/구 디자인 시스템이 공존하는 레포에서는 adapter를 사용한다.

예시 구조:

```text
shared/ui/
├── index.ts
├── Button.tsx
└── tokens.ts
```

원칙:

- 앱 코드가 직접 레거시 패키지를 대량 참조하지 않도록 중간 계층 유지
- 마이그레이션 시 adapter 내부 구현만 교체

## 6) Review Checklist

1. 토큰 우선 사용 여부
2. 공통 컴포넌트 우선 사용 여부
3. 하드코딩 값 최소화 여부
4. 반응형 기준값 상수화 여부
5. 접근성 속성(`aria-*`, `role`) 누락 여부

## 7) Visual Regression Risk Points

- 버튼 variant 이름 오용
- Disabled 상태 스타일 누락
- hover/focus 스타일 불일치
- 텍스트 truncation과 line-clamp 기준 불일치

## 8) Escape Hatch

예외가 필요한 경우 PR에 아래를 기록:

```text
[Design System Exception]
- reason:
- scope:
- expire:
- follow-up:
```

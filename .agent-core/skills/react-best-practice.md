# React Best Practice (Generic)

React 기반 레포에서 재사용 가능한 실전 패턴.

## 목표

- 렌더링 안정성
- 상태 경계 명확화
- 관심사 분리

## 1) State Ownership

원칙:

- UI 상태는 컴포넌트 로컬
- 서버 상태는 React Query
- 전역 상태는 최소화 (정말 공유가 필요한 경우만)

금지:

- 서버 응답을 전역 store로 복제
- 하나의 store에 unrelated 도메인 상태 혼합

## 2) Component Boundary

분리 기준:

- 비즈니스 로직 훅 (`useXxxLogic`)
- 프레젠테이션 컴포넌트 (`XxxView`)
- 데이터 조회 훅 (`useGetXxx`)

예시:

```text
features/campaign/
├── hooks/
│   ├── useCampaignFormLogic.ts
│   └── queries/
├── components/
│   ├── CampaignFormView/
│   └── CampaignCard/
└── pages/
```

## 3) Effect Hygiene

- `useEffect`는 동기화 용도에 한정
- 계산 로직은 `useMemo`가 아니라 순수 함수 우선
- `useEffect` 내부 비동기 함수는 abort/cleanup 고려

## 4) Event Handler Rules

- 핸들러 이름은 의도 중심 (`handleSubmitCampaign`)
- 인라인 익명 핸들러 남발 지양
- 복잡한 핸들러는 함수 추출

## 5) Error/Loading UX

- 로딩/에러/빈 데이터 상태를 분리 렌더
- 예외 케이스가 UI에 드러나는지 테스트로 보장

## 6) Performance Rules

- `memo/useMemo/useCallback`은 증거 기반 사용
- 리스트 렌더링 시 key 안정성 보장
- 파생값은 렌더 중 계산하거나 selector 함수로 분리

## 7) Accessibility Baseline

- 클릭 가능한 요소는 의미론적 태그 사용
- 버튼/링크 role 혼용 금지
- 폼 요소 label 연결

## 8) Review Questions

1. 서버 상태와 UI 상태가 분리됐는가?
2. effect가 정말 필요한가?
3. 예외 상태(로딩/에러/빈값)가 처리됐는가?
4. 테스트가 사용자 행동을 검증하는가?

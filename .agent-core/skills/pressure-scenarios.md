# Pressure Scenarios (Generic FE)

긴급 상황에서도 품질 하한선을 지키기 위한 가드레일.

## 절대 타협 금지 5가지

1. `any` 추가 금지
2. query version 혼용 금지
3. 디자인 시스템 무시 금지
4. 스타일 분리 규칙 무시 금지
5. 최종 검증 생략 금지

## 시나리오별 대응

### 1) 데드라인 직전

- 목표: 작동 + 회귀 방지 최소선
- 실행: scope 축소 -> 핵심 경로 테스트 -> 배포

### 2) 타입 에러 지옥

- `as any` 금지
- `unknown` + type guard로 우회
- 타입 경계 파일(`types.ts`) 분리

### 3) UI 급수정 요청

- 디자인 시스템 우선
- 토큰 없는 값만 하드코딩
- 하드코딩 값은 follow-up 이슈 생성

### 4) 레포 전환 직후

- `project-profile-selector` 재실행
- 명령어/alias/query 버전 재고정

## 긴급 PR 템플릿

```text
[Hotfix Scope]
- user impact:
- changed files:

[Safety]
- lint:
- typecheck:
- build/test:

[Follow-up]
- cleanup ticket:
- owner:
- due date:
```

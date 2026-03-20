# PR Checklist

PR 직전 최종 검증 스킬.

## 1) Profile Check

- 적용 profile 재확인
- package manager 일치
- alias/query 버전 혼용 없음

## 2) Convention Check

- 신규/수정 라인 `any` 없음
- query key factory 적용
- invalidation 범위 최소화
- 디자인 시스템/토큰 우선 사용
- 스타일 분리 규칙 준수

## 3) Validation Check

- Small: `lint`
- Normal: `lint + typecheck`
- High-risk: `lint + typecheck + build`
- PR final: `lint + typecheck + build`

## 4) Diff Quality Check

- 불필요 파일 생성 없음
- dead code/console debug 정리
- 파일 이동/이름 변경 이유 명확

## 5) Risk Note

- 알려진 리스크 기록
- 후속 작업 티켓 연결
- SHOULD 예외 시 `rule/reason/expire` 명시

## 6) Required Report Format

```text
[Profile]
- repo:
- profile:

[Validation]
- lint:
- typecheck:
- build/test:

[Risk]
- none | <risk summary>

[Exception]
- none | <rule/reason/expire>
```

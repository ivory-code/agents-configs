# Past Mistakes (Generic FE)

반복된 안티패턴 기록.
항목은 3회 이상 반복 시 유지하고, 해결되면 정리한다.

## CRITICAL

- `any`로 타입 우회
- query key 충돌/과도한 invalidation
- import 경로 오류로 빌드 실패

## HIGH

- 파일 크기 폭증(단일 파일 800+ 라인)
- 디자인 시스템 미사용으로 UI 불일치
- `catch { throw error }` 형태의 의미 없는 try-catch
- styled 분리 누락

## MEDIUM

- `useMemo/useCallback` 남용
- props 과다(8개 이상 개별 전달)
- 날짜/숫자 포맷 유틸 미사용으로 표현 불일치
- transient props `$` 접두사 누락

## 운영 규칙

1. 항목에는 항상 재현 조건과 교정 패턴을 같이 기록
2. 개인 취향이 아닌 팀 공통 품질 이슈만 기록
3. 단순 문체 논쟁은 기록하지 않음

# Superpowers Operating Model (Generic)

`superpowers`를 팀 운영에 맞게 적용하는 실무 모델.

## 기본 흐름

1. 문제 정의
2. brainstorming
3. 계획 수립
4. 구현
5. 코드 리뷰
6. 검증/완료

## Recommended Mode Mapping

- 설계 전: brainstorming
- 구현 중: test-driven-development 또는 writing-plans
- 완료 전: requesting-code-review + verification-before-completion

## 병렬 작업 원칙

- 독립 작업만 병렬화
- 공유 파일이 겹치면 순차 처리
- 병렬 작업 후 통합 검증 필수

## 실패 방지 규칙

- 결과 주장 전에 명령어 증거 확보
- 추측 대신 로그/테스트 출력 기반 보고
- "되는 것 같다" 표현 금지

## 운영 체크리스트

1. 현재 단계가 명확한가?
2. 다음 단계 입력이 준비됐는가?
3. 검증 커맨드를 실행했는가?
4. 리스크/미완료 항목을 명시했는가?

## 결과 보고 템플릿

```text
[What]
- 변경 목적:
- 핵심 변경:

[Verify]
- lint:
- typecheck:
- test/build:

[Risk]
- known risk:
- follow-up:
```

# agents-configs

개인용 에이전트 설정/스킬 저장소입니다.

목표:
- 특정 도메인에 묶이지 않는 공통 규칙과 스킬을 관리
- Claude/Codex를 분리된 dot 디렉토리로 운영
- 여러 사이드 프로젝트에 빠르게 재사용

구조:
- `.agent-core/`: 벤더 중립 공통 규칙/스킬
- `.claude/`: Claude 전용 엔트리/설정
- `.codex/`: Codex 전용 엔트리/설정
- `scripts/`: 신규 프로젝트에 설정 배포/동기화 도구

빠른 시작:
```bash
# 예시: 현재 프로젝트에 codex 설정 배포
./scripts/bootstrap.sh codex /path/to/project

# 예시: 현재 프로젝트에 claude 설정 배포
./scripts/bootstrap.sh claude /path/to/project
```

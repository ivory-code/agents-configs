# agents-configs

개인용 에이전트 설정/스킬 저장소입니다.

목표:
- 특정 도메인에 묶이지 않는 공통 규칙과 스킬을 관리
- Claude/Codex를 분리된 dot 디렉토리로 운영
- 여러 사이드 프로젝트에 빠르게 재사용

구조:
- `.agent-core/`: 벤더 중립 공통 규칙/스킬
- `.agent-core/blueprints/`: 신규 스킬/프로필 작성 템플릿
- `.claude/`: Claude 전용 엔트리/설정
- `.codex/`: Codex 전용 엔트리/설정
- `docs/`: 범용 스킬셋 설계 문서
- `scripts/`: 신규 프로젝트에 설정 배포/동기화 도구

핵심 문서:
- `docs/UNIVERSAL_SKILLSET_BLUEPRINT.md`: 범용 스킬셋 아키텍처
- `.agent-core/blueprints/skill-template.md`: 신규 스킬 작성 보일러플레이트
- `.agent-core/blueprints/profile-template.md`: 신규 레포 프로필 작성 보일러플레이트

빠른 시작:
```bash
# 예시: 현재 프로젝트에 codex 설정 배포
./scripts/bootstrap.sh codex /path/to/project

# 예시: 현재 프로젝트에 claude 설정 배포
./scripts/bootstrap.sh claude /path/to/project
```

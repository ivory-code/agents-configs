# Vercel Composite Patterns (Generic)

Next.js/Vercel 계열 프로젝트에서 많이 쓰는 컴포지션 패턴 모음.

## 1) Layout Composition

권장:

- 페이지 레벨에서 레이아웃 조합
- 공통 shell과 페이지 콘텐츠 분리

```ts
export function DashboardPage() {
  return (
    <AppShell>
      <DashboardHeader />
      <DashboardContent />
    </AppShell>
  )
}
```

## 2) Slot Pattern

재사용 레이아웃은 slot props로 확장한다.

```ts
interface SectionLayoutProps {
  header: React.ReactNode
  body: React.ReactNode
  footer?: React.ReactNode
}
```

## 3) Server/Client Boundary

- 데이터 fetching/secret 접근은 서버 경계
- 상호작용 UI는 클라이언트 경계
- 경계 파일명과 디렉토리로 의도를 명시

## 4) Route Segment Isolation

- 라우트 단위로 feature를 격리
- 페이지 간 공유 로직은 `shared/` 또는 `lib/`로 추출

## 5) Data Fetching Contract

원칙:

- 페이지 단에서는 응답 shape 변환 최소화
- 변환은 adapter/mapper 계층으로 이동

## 6) Edge-Safe Coding

- Node 전용 API는 edge 경로에서 사용 금지
- 런타임 제약을 profile/route config에 명시

## 7) Build Safety

- 환경변수 사용 위치를 server/client로 명확히 구분
- 클라이언트 번들 유출 가능한 값인지 검토

## 8) Failure Modes

- layout depth 과다로 가독성 저하
- server/client 경계 혼합으로 hydration 오류
- 페이지별 임시 mapper 중복 증가

## 9) Review Checklist

1. 경계가 파일 구조로 명확한가?
2. slot/pattern이 재사용 가능한가?
3. 데이터 변환이 한 곳에 집중됐는가?
4. 런타임 제약(edge/node)이 반영됐는가?

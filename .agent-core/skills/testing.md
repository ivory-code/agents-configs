# Testing (Generic FE)

프론트엔드 테스트 운영 스킬.
목적은 "핵심 플로우 회귀 차단"과 "리팩터링 안전성 확보".

## Test Strategy

- Risk-based 우선순위로 테스트를 배치한다.
- 모든 파일 100%보다, 사고 가능성이 큰 영역에 집중한다.

우선순위:

- P0: 인증/권한/결제/정산/핵심 전환
- P1: 주요 사용자 여정
- P2: 재사용 훅/유틸
- P3: 단순 표시 컴포넌트

## Tooling

- Vitest
- React Testing Library
- user-event
- MSW

## File Placement

```text
Feature/
├── index.tsx
├── index.test.tsx
└── styled.ts
```

## Query Version Rules

- v3: `react-query`
- v5: `@tanstack/react-query`
- profile을 확인하고 버전을 고정한다.

## Query Wrapper Template

```ts
function createQueryClient() {
  return new QueryClient({
    defaultOptions: {
      queries: { retry: false },
      mutations: { retry: false },
    },
  })
}

export function withQueryClient(ui: React.ReactElement) {
  const client = createQueryClient()
  return render(<QueryClientProvider client={client}>{ui}</QueryClientProvider>)
}
```

## Component Test Pattern

```ts
describe('ProfileCard', () => {
  it('renders name', () => {
    withQueryClient(<ProfileCard userName='alex' onOpen={vi.fn()} />)
    expect(screen.getByText('alex')).toBeInTheDocument()
  })

  it('calls handler on click', async () => {
    const onOpen = vi.fn()
    withQueryClient(<ProfileCard userName='alex' onOpen={onOpen} />)

    await userEvent.click(screen.getByRole('button'))
    expect(onOpen).toHaveBeenCalledTimes(1)
  })
})
```

## Hook Test Pattern

```ts
it('returns campaign list', async () => {
  const wrapper = ({ children }: { children: React.ReactNode }) => (
    <QueryClientProvider client={createQueryClient()}>{children}</QueryClientProvider>
  )

  const { result } = renderHook(() => useCampaignList(), { wrapper })

  await waitFor(() => expect(result.current.isSuccess).toBe(true))
  expect(result.current.data).toBeDefined()
})
```

## MSW Rules

- 외부 API는 네트워크 레벨에서 모킹
- 성공/실패/빈 데이터 3가지 기본 시나리오 포함
- 에러 코드별 UX 분기(401/403/500) 테스트를 최소 1개 포함

## RTL Query Priority

```text
getByRole > getByLabelText > getByText > getByTestId
```

## Do Not Test

- 순수 스타일 값(assert css literal)
- 프레임워크 내부 동작
- 구현 디테일(private state)만 검증하는 테스트

## Completion Gate

- `lint` pass
- `typecheck` pass
- 테스트 실행 pass
- high-risk 변경 시 `build` pass

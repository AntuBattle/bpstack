# Feature

1. Name the user-visible outcome and the core data shape/state transition before writing logic.
2. Inspect the existing caller, boundary, and test/verification path. Reuse the native shape when it already fits.
3. Write a throughput checkpoint: what can be implemented and verified as one coherent unit, and what is explicitly out of scope.
4. Settle cross-boundary types/contracts before implementation. Prototype only genuine empirical forks. Read [Review and verify](review-and-verify.md) and apply its early shape review when triggered.
5. Implement the smallest end-to-end slice that produces the outcome.
6. Run targeted local tests with mocked external services first, then broader local checks as warranted. Follow [Review and verify](review-and-verify.md) for local E2E and the final sequential review loop. Report verification evidence and any gaps.

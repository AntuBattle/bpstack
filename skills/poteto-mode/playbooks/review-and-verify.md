# Review and verify features and bug fixes

This checklist applies to every feature and bug fix, including minor patches. It does not replace targeted tests or the original bug reproduction.

## Before implementation

If the proposal changes ownership, shared state, an interface, or a significant abstraction, ask one isolated subagent to assess the proposed design using the shape lens below. If delegation is unavailable, do a labeled shape self-review. Resolve major findings before implementation. This does not replace the final shape review of the actual diff.

## Local end-to-end verification

After targeted local checks pass, run the actual app locally in isolation for every behavior-changing change, even a one-line fix. For work intended to preserve behavior, prove the relevant before/after behavior through the real entry point when it could regress. Use the consumer-facing entry point of the artifact you are changing; for a library that can be a real integration consumer. Mock external services at their boundaries; do not mock the app path under test. Use the repository's existing verification skill or harness if available. Drive the changed workflow through its normal UI, CLI, or API. Run the relevant E2E tests. If coverage is missing and the existing harness makes it practical, add and run a focused test. Otherwise drive the same path locally, record the expected and observed result, and note the automation gap. For fixes, verify that the original symptom no longer occurs.

For each material acceptance criterion, record the exact candidate revision or snapshot, command or steps, expected and observed behavior, what was mocked, and any evidence location. Exercise a relevant failure or boundary case as well as the happy path. Clean up the app and mocks. If local E2E is impossible or not applicable, record `skip: <concrete reason>` and what remains unverified. Missing or failed E2E blocks readiness and shipping for behavior-changing work. Unit tests, builds, and tests that bypass the consumer-facing path are not E2E. Do not contact live services as a substitute for mocks; any separate real-service verification follows Poteto Mode's permission rules.

## Sequential review loop

Review the exact candidate diff and verification evidence. Include the original request, spec, or bug report and reproduction, plus acceptance criteria and scope limits. Use one isolated, read-only subagent per lens, with a fresh invocation for each. Wait for each review to finish before starting the next; do not fan out. Complete all three reviews against the unchanged candidate before editing it. If delegation is unavailable, run the same lenses sequentially and disclose that independent review was unavailable.

1. **Shape:** Is the change in the right layer? Examine ownership, boundaries, state and invariants, and whether the abstractions follow repository practices and principles such as SOLID and YAGNI. Check single responsibility, useful reuse, and meaningful duplication. Group common logic when it shares a responsibility; don't add abstraction or extensibility on speculation.
2. **Code:** Is the implementation correct? Inspect the diff, affected callers, and tests for concrete failure modes, compatibility breaks, missed edge cases, and relevant security, performance, or concurrency regressions. Check that tests assert observable behavior.
3. **Intent:** Does the result deliver what the original request or spec asked for? Compare actual behavior and test evidence with the source requirements. Check for missing outcomes or constraints and unrelated changes that exceed scope. For fixes, check that the original failure is resolved, not just hidden.

Each reviewer reports whether any major issue remains and cites the affected behavior and evidence for each finding. The implementing agent evaluates the evidence and owns the fixes. Block on material issues such as unmet requirements, incorrect behavior, usability, performance, security, compatibility, or significant design risks. Treat minor polish with no meaningful impact as non-blocking.

If a round raises a major issue, fix it or present evidence that it is not a blocker in the next round. After edits, re-run affected checks, including local E2E when the edits could invalidate its result. Repeat all three reviews in order after any major finding or candidate change. Finish only when all three lenses report no major issues on the same candidate. If a blocker cannot be resolved, report it rather than claiming the gate passed. In the handoff, summarize the review result, verification evidence, and any gaps.

# Bug fix

1. Reproduce the defect on the closest real surface available. Record exact observed and expected behavior.
2. Trace the failing behavior to a root cause before editing. If the symptom cannot be reproduced, gather evidence rather than guessing.
3. When a cheap automated path exists, add or identify a behavior-level check that fails for the same reason.
4. Read [Review and verify](review-and-verify.md) and apply its early shape review when triggered. Make the smallest change that fixes the root cause. Avoid nearby cleanup unless it reduces the fix itself.
5. Re-run the reproduction and targeted local checks with mocked external services, then the smallest broader suite that can catch collateral damage. Follow [Review and verify](review-and-verify.md) for local E2E and the final sequential review loop.
6. Report root cause, change, proof, and any verification surface that was unavailable.

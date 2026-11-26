# Open a pull request

1. Review the complete diff against the task and remove unrelated changes.
2. Run targeted and required repository checks. For behavior-changing work, require passing local end-to-end verification against the intended behavior and a clear review verdict on the same candidate. Follow [Review and verify](review-and-verify.md). If the gate is blocked, report why and do not open or mark the PR ready. Open an unverified draft only when the user explicitly requests a draft and authorizes the action; document its blockers.
3. Write a concise title and description centered on user/maintainer impact, root cause or design choice, and verification. Prefer a Conventional Commits-style PR title (`type(scope): summary`) unless the repository explicitly follows another title standard.
4. Open the PR through the available VCS host only when permissions allow. Return the real URL or identifier; never invent one.
5. Refresh status once and report any immediate blocker.

---
name: principle-prove-it-works
description: Verify changes locally first with mocked external services; use real surfaces only when appropriate and authorized. Use when verifying changes, completing tasks, or claiming something is fixed.
---
# Prove It Works

## Trigger

When verifying changes, completing tasks, or claiming something is fixed.

## Rule

Test locally first with mocked external services. After local checks pass, verify against the real artifact or surface only when appropriate and authorized; a proxy check only proves the proxy. Never use stronger proof as a reason to bypass environment safety or user permission.

## Application

1. Name the concrete decision this principle changes.
2. Apply the rule to that decision, not as a decorative citation.
3. Prefer evidence from the current repository/runtime over generic preference.
4. Before any real-service test, identify whether the target is isolated. Treat a cluster named `test`, `dev`, or similar as potentially production if it is shared or its isolation is unconfirmed. On any non-isolated service, verification must be read-only and non-destructive. Write or destructive tests require an isolated test instance and explicit authorization.
5. If permission for remote access or real-service verification in this task is ambiguous, ask the user first, even for read-only access. Prior permission to investigate does not authorize testing a new implementation. If permission is unavailable, report the local evidence and state that real-surface behavior remains unverified.
6. If the principle conflicts with an explicit user constraint, keep the constraint and state the tradeoff.

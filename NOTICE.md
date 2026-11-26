# Attribution and provenance

**bpstack** is an independent downstream fork and extension of the skills from [potetos-for-everyone](https://github.com/TheOnlyFusionCube/potetos-for-everyone), itself a portability-focused adaptation of **pstack**. This is a skills snapshot plus new documentation, installation checks, and stronger verification instructions, not a GitHub fork of the entire Cursor plugin repository.

## Original work

- **pstack / Poteto Mode:** Lauren Tan ([`@poteto`](https://github.com/poteto))
- Upstream: https://github.com/cursor/plugins/tree/main/pstack
- Upstream license: MIT
- Upstream copyright: **Copyright (c) 2026 Lauren Tan**
- Initial pstack adaptation baseline (Cursor plugin history, recorded by potetos-for-everyone): `d7cde2b84eadbcd6fd890302c876f4436ccb6d82`
- Immediate source: the locally modified `~/.agents/skills` snapshot of potetos-for-everyone. The snapshot is not an unmodified upstream revision.

Lauren Tan's original pstack introduced the core architecture this project adapts: Poteto Mode as a routing skill, task-specific engineering playbooks, small principle skills, deliberate multi-agent review/fan-out, and verification as a completion condition.

The portability adaptation rewrites those ideas around a vendor-neutral capability contract and the open Agent Skills format. bpstack builds on that work and tightens the local E2E and intent-review gates. It is not affiliated with or endorsed by Lauren Tan or Cursor.

The original MIT copyright and permission notice are preserved in `LICENSE` as required for copied or substantially adapted portions.

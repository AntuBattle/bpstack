# Agent instructions

For non-trivial engineering work, read [`skills/poteto-mode/SKILL.md`](skills/poteto-mode/SKILL.md), then read the selected playbook in full. Load supporting skills only when they change a decision. If the host cannot discover skills, read the files directly.

For behavior changes, verify the original user intent through the actual local entry point with mocked external dependencies. Record the exact candidate, expected and observed outcomes, and gaps. Follow the [review and verification gate](skills/poteto-mode/playbooks/review-and-verify.md) before opening or marking a PR ready or shipping it. Never report missing evidence as a pass.

When changing this repository, run `python3 scripts/check_catalog.py` and `bash scripts/smoke-install.sh`. Keep the [skill index](docs/skills.md) and [playbook guide](docs/playbooks.md) in sync. Do not commit credentials, private transcripts, vendor caches, or account-specific runtime state.

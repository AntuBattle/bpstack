# Optional Pi global instructions

- For non-trivial engineering work, read the installed `poteto-mode` skill before choosing a workflow. If native discovery is unavailable, read `~/.agents/skills/poteto-mode/SKILL.md` and its selected playbook directly.
- When the task and repository guidelines call for a separate branch or worktree, use `treehouse get --lease` if available and create or switch to the required branch inside it. Otherwise use the host's normal worktree mechanism.
- When opening a pull request or merge request, honor the repository's reviewer policy. For PnR-related work (including WMCore, WMAgent, and Unified), add both configured reviewers and report if either cannot be added. Keep the actual account list in your local configuration.

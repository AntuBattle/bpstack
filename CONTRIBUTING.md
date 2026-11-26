# Contributing

Start with the user or agent behavior you want to change. A new skill should fill a gap that a playbook or a small edit to an existing skill cannot cover. Keep canonical instructions runtime-neutral; put host-specific setup in `docs/` or `profiles/`.

1. Change the smallest skill or playbook that owns the behavior. When adding one, update the router and reference guide where relevant.
2. Run `python3 scripts/check_catalog.py`, `bash scripts/smoke-install.sh`, and `git diff --check` from the repo root.
3. For instruction behavior changes, try a representative prompt in the target host with both a matching and a non-matching case. Verify what it actually routes to, which actions it takes, what it reports when proof is blocked, and whether the result matches the intent. Record the candidate, host/model, prompt, and observed result without including private conversation or credentials. The catalog and installer checks cannot establish model compliance.
4. For installer or loader changes, run the real installer or host discovery in an isolated directory. Include at least one failure case that proves an existing installation stays intact.
5. In the PR, describe the intended behavior, the checks that establish it, and anything still unverified.

To enable the same catalog and installer checks in GitHub Actions, copy the [validation workflow template](.github/workflow-templates/validate.yml) to `.github/workflows/validate.yml` and commit it using an account or token authorized to write workflows.

Preserve attribution and license notices. Do not add copied vendor skills, synced state, local reviewer account lists, tokens, or machine-specific paths.

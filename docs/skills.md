# Skill directory

Start with [Poteto Mode](../skills/poteto-mode/SKILL.md) for engineering work that needs a workflow, or choose a specific skill below for a focused task. All 48 skills live in `skills/`. The groupings are for lookup, not loading order.

[Use a skill](#use-a-skill) · [How skills fit together](#how-skills-fit-together) · [Browse the directory](#directory)

## Use a skill

### In Pi

If the skills aren't already discoverable, start Pi from this repository's root with the canonical tree. `--no-skills` turns off automatic discovery for this run; `--skill` explicitly loads the skills in `./skills`.

```sh
pi --no-skills --skill ./skills
```

At the Pi prompt, type `/skill:<name>` using the exact `name` from the skill's frontmatter. Text after the name is the task for the agent. Try this against the checkout:

```text
/skill:how Trace what Poteto Mode asks the agent to read and verify for a bug fix. Use only local files, cite them, and don't edit anything.
```

For a task in your own project with the skills loaded, use a focused skill directly:

```text
/skill:tdd Fix the CSV import so a blank quantity is rejected. Reproduce it with a behavior-level test first, then run the targeted local tests. Don't commit or push.
```

Use `/skill:poteto-mode` instead of `/skill:tdd` to start with playbook routing. Pi can also select a discovered skill from its description; use the explicit command if you want to make sure Pi loads it. For a discovery check, type `/skill:` in the interactive prompt and look for `poteto-mode`, `how`, and `tdd` in the suggestions (with skill command suggestions enabled). Seeing a command confirms discovery, not that the agent followed the workflow.

### In any agent that can read the files

Slash commands are host-specific. Name the skill and its path in plain language. If the host doesn't discover skills, point it at the checkout or supply the referenced files.

> Read `skills/poteto-mode/SKILL.md` and use it to fix the CSV import bug where blank quantities become zero. Reproduce the defect locally, follow the matching playbook, run the targeted checks, and say which checks you could not run. Don't contact external services, commit, or publish.

> Use `skills/blast-radius/SKILL.md` to review this proposed config rename. Map current readers, writers, and compatibility risks. Cite the files you inspected and don't change anything.

## How skills fit together

| Layer | File shape | What it does |
| --- | --- | --- |
| Skill entry point | `skills/<name>/SKILL.md` | YAML frontmatter advertises the skill; the Markdown body tells the agent what to do. |
| Router | [`skills/poteto-mode/SKILL.md`](../skills/poteto-mode/SKILL.md) | Its **Routing** section matches the task to a playbook. Its **Execution** section explains how to use that playbook and when to load support. |
| Playbook | [`skills/poteto-mode/playbooks/<task>.md`](../skills/poteto-mode/playbooks/) | A Markdown checklist or procedure, read in full after selection. Playbooks aren't separately discoverable skills or `/skill:` commands. |
| Supporting skill or principle | Another `skills/<name>/SKILL.md` | Loaded only when a step calls for its method or rule. These use the same format as other skills and can be invoked directly. |

Every skill here uses two frontmatter keys: `name` (the identifier matching the directory, in lowercase with hyphens between words) and `description` (what the skill does and when to use it). For example:

```markdown
---
name: tdd
description: Write a minimal failing test before implementation, make it pass with the simplest code, and refactor cleanly. Use when implementing bug fixes or features with clear verification targets.
---

# Test-Driven Development (TDD)

<!-- Markdown instructions follow. -->
```

The Markdown body has no fixed heading schema. Principle skills typically use **Trigger**, **Rule**, and **Application**. For longer material, keep the entry point focused and link to files relative to its directory. The [Agent Skills format](https://agentskills.io/specification) also supports optional frontmatter and bundled `scripts/`, `references/`, and `assets/`.

For example, Poteto Mode routes a defect to the [bug-fix playbook](../skills/poteto-mode/playbooks/bug-fix.md). The playbook starts with a reproduction, traces the root cause, and points to the shared [review and verification checklist](../skills/poteto-mode/playbooks/review-and-verify.md). If there's a cheap behavior-level regression test, [`tdd`](../skills/tdd/SKILL.md) gives the agent a method for checking that it fails before the fix and passes afterward. The playbook is the task checklist; the supporting skill is guidance for a particular step. The router asks the agent to record `skip: <reason>` for steps that would normally apply but couldn't be done. See the [playbook guide](playbooks.md) to compare routes.

The workflow only uses capabilities the host actually provides. Without isolated workers, review passes are sequential and not independent. Without command execution, runtime proof is unavailable. See [Portability contract](../PORTABILITY.md) for fallbacks. When verifying a change, start locally with external services mocked where needed; report what you ran, what you observed, and what remains unverified. Only use real services when appropriate and authorized.

## Directory

### Route and coordinate work

| Skill | Use it to |
| --- | --- |
| [`poteto-mode`](../skills/poteto-mode/SKILL.md) | Route an engineering task to a playbook and track it through verification. |
| [`figure-it-out`](../skills/figure-it-out/SKILL.md) | Write a custom playbook for large or unusual work that doesn't fit a bundled one. |
| [`arena`](../skills/arena/SKILL.md) | Compare competing implementations, cross-review them, and combine the best parts. |
| [`swarm`](../skills/swarm/SKILL.md) | Split a large job into independent slices and verify the combined result. |
| [`show-me-your-work`](../skills/show-me-your-work/SKILL.md) | Keep a concise, auditable decision log for long or high-stakes work. |

### Design and implement

| Skill | Use it to |
| --- | --- |
| [`architect`](../skills/architect/SKILL.md) | Settle data shapes, ownership, and contracts before crossing a boundary. |
| [`make-bot-ui`](../skills/make-bot-ui/SKILL.md) | Build a small operator UI over an agent or webhook backend. |
| [`tdd`](../skills/tdd/SKILL.md) | Write a failing test, make it pass with the smallest fix, and refactor. |
| [`typescript-best-practices`](../skills/typescript-best-practices/SKILL.md) | Model states explicitly and parse external data at TypeScript boundaries. |

### Investigate, review, and verify

| Skill | Use it to |
| --- | --- |
| [`blast-radius`](../skills/blast-radius/SKILL.md) | Trace affected callers, contracts, state, and behavior. |
| [`broader-scope-analysis`](../skills/broader-scope-analysis/SKILL.md) | Decide whether proposed work is needed and belongs in this layer before reviewing its implementation. |
| [`create-verification-skill`](../skills/create-verification-skill/SKILL.md) | Create a project-local skill that drives the real app and records evidence. |
| [`how`](../skills/how/SKILL.md) | Trace how a subsystem works from code and runtime evidence. |
| [`interrogate`](../skills/interrogate/SKILL.md) | Challenge a design or diff with separate review lenses and concrete evidence. |
| [`maintain-verification-skill`](../skills/maintain-verification-skill/SKILL.md) | Update a project's verification skill when commands or feature coverage drift. |
| [`why`](../skills/why/SKILL.md) | Recover the rationale behind a decision from history and related evidence. |

### Explain and edit

| Skill | Use it to |
| --- | --- |
| [`bro`](../skills/bro/SKILL.md) | Restate the last explanation in everyday language. |
| [`no-comments`](../skills/no-comments/SKILL.md) | Remove redundant code comments without losing important constraints. |
| [`teach`](../skills/teach/SKILL.md) | Explain how a system works and why it was built that way. |
| [`technical-writing`](../skills/technical-writing/SKILL.md) | Write durable engineering docs and change descriptions. |
| [`unslop`](../skills/unslop/SKILL.md) | Cut filler and formulaic prose without losing precision. |

### Configure, resume, and improve the workflow

| Skill | Use it to |
| --- | --- |
| [`automate-me`](../skills/automate-me/SKILL.md) | Turn recurring personal workflow patterns into a skill. |
| [`recall`](../skills/recall/SKILL.md) | Rebuild task context from durable notes and history. |
| [`reflect`](../skills/reflect/SKILL.md) | Turn lessons from a difficult task into improvements to the system or workflow. |
| [`setup-pstack`](../skills/setup-pstack/SKILL.md) | Detect host capabilities and configure optional worker and reviewer roles. |

### Principles: design and boundaries

| Skill | Use it to |
| --- | --- |
| [`principle-boundary-discipline`](../skills/principle-boundary-discipline/SKILL.md) | Validate and normalize input at the edge so internal logic can trust invariants. |
| [`principle-exhaust-the-design-space`](../skills/principle-exhaust-the-design-space/SKILL.md) | Compare materially different prototypes before committing to a design. |
| [`principle-experience-first`](../skills/principle-experience-first/SKILL.md) | Choose the better user experience within explicit constraints. |
| [`principle-foundational-thinking`](../skills/principle-foundational-thinking/SKILL.md) | Choose core data structures, ownership, and sequencing before writing logic. |
| [`principle-model-the-domain`](../skills/principle-model-the-domain/SKILL.md) | Replace scattered conditions with an explicit domain model. |
| [`principle-redesign-from-first-principles`](../skills/principle-redesign-from-first-principles/SKILL.md) | Design for the current requirements rather than extending a mismatched abstraction. |
| [`principle-separate-before-serializing-shared-state`](../skills/principle-separate-before-serializing-shared-state/SKILL.md) | Remove sharing or split ownership before adding synchronization. |
| [`principle-type-system-discipline`](../skills/principle-type-system-discipline/SKILL.md) | Use types to rule out invalid states and represent parsed data. |

### Principles: scope and complexity

| Skill | Use it to |
| --- | --- |
| [`principle-attack-the-premise`](../skills/principle-attack-the-premise/SKILL.md) | Recheck ownership and challenge a shared assumption when repeated fixes fail the same check. |
| [`principle-guard-the-context-window`](../skills/principle-guard-the-context-window/SKILL.md) | Keep bulk exploration out of the main context and return compact evidence. |
| [`principle-laziness-protocol`](../skills/principle-laziness-protocol/SKILL.md) | Prefer deletion or the smallest change that solves the whole problem. |
| [`principle-migrate-callers-then-delete-legacy-apis`](../skills/principle-migrate-callers-then-delete-legacy-apis/SKILL.md) | Move callers and remove the old internal path in the same migration. |
| [`principle-minimize-reader-load`](../skills/principle-minimize-reader-load/SKILL.md) | Reduce indirection and hidden state so the causal path is easy to follow. |
| [`principle-outcome-oriented-execution`](../skills/principle-outcome-oriented-execution/SKILL.md) | Finish a migration at the target design rather than keeping temporary compatibility paths. |
| [`principle-subtract-before-you-add`](../skills/principle-subtract-before-you-add/SKILL.md) | Remove obsolete paths before building on the remaining system. |

### Principles: execution and evidence

| Skill | Use it to |
| --- | --- |
| [`principle-build-the-lever`](../skills/principle-build-the-lever/SKILL.md) | Use a repeatable script, tool, or check instead of repeating manual work. |
| [`principle-encode-lessons-in-structure`](../skills/principle-encode-lessons-in-structure/SKILL.md) | Turn a recurring correction into a type, check, test, or skill. |
| [`principle-fix-root-causes`](../skills/principle-fix-root-causes/SKILL.md) | Reproduce a symptom and fix the mechanism that causes it. |
| [`principle-make-operations-idempotent`](../skills/principle-make-operations-idempotent/SKILL.md) | Make repeated runs converge without duplicate side effects. |
| [`principle-never-block-on-the-human`](../skills/principle-never-block-on-the-human/SKILL.md) | Resolve reversible questions with evidence; ask when preference, authority, or an irreversible decision is needed. |
| [`principle-prove-it-works`](../skills/principle-prove-it-works/SKILL.md) | Verify locally first and distinguish direct evidence from proxy checks. |
| [`principle-sequence-verifiable-units`](../skills/principle-sequence-verifiable-units/SKILL.md) | Break work into steps with a check at the end of each. |
| [`principle-test-behavior-not-implementation`](../skills/principle-test-behavior-not-implementation/SKILL.md) | Test outcomes through the interface a consumer uses. |

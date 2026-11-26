# Read-only investigation

For an issue, PR, or planned change asking whether the work is needed or belongs here, load `broader-scope-analysis` first. Record its pre-diff baseline before inspecting any diff. Run `interrogate` only afterward if the implementation itself needs review. For other investigations, use the steps below directly.

Identify the revision or working snapshot under investigation. Inspect a supplied local snapshot as-is. When the question depends on the latest remote state, fetch refs and inspect the named revision without changing the user’s checkout unless authorized.

1. Restate the question as a falsifiable claim or a small set of claims.
2. Map the evidence that can answer it: code, tests, history, docs, tickets, runtime data, or connected sources. Read the highest-signal source first.
3. Trace the relevant call/data path end to end. Separate observed facts from inference.
4. Try to disprove the leading explanation with one targeted counter-check.
5. Answer the question directly. Cite concrete files, revisions, commands, or external evidence that were actually inspected. Name unresolved gaps.

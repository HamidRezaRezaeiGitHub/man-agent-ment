# Prompt: Continue Requirement

Use this in a project with installed AI workflow instructions when a fresh agent session should continue an existing requirement, including one planned or started by another agent.

```text
Continue an existing requirement.

Requirement locator:
<paste the requirement title, slug, branch, path, issue link, or any known context here>

Additional context:
<paste any new request details, constraints, review notes, or changes since the last session here>

Use this project's installed AI instructions. Treat this as a resume, not a restart. Start with `ai/workflows/requirement-planning.md`, especially the resuming-agent guidance.

Use `ai/workflows/workflow-dispatch.md` only if the existing plan does not already make the route clear. Continue from the next unfinished checklist item, handoff note, blocker, or validation gap in the requirement workspace.

Do not redo completed research unless the plan says it is stale, blocked, or suspect. If the previous plan is too sparse to continue safely, refresh the requirement workspace before implementation.

If a decision would change scope, implementation, validation, rollout, or risk, use the installed interview-question guidance and include your recommended default. Otherwise, make reasonable assumptions, record them in the requirement workspace, and continue.

Before finishing, use `ai/workflows/ci-validation.md`, `ai/workflows/code-review.md`, and `ai/workflows/wiki-documentation.md` as applicable.
```

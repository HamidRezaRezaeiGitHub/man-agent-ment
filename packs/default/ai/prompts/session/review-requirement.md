# Prompt: Review Requirement

Use this in a project with installed AI workflow instructions when an agent should review an active or completed requirement before more work, handoff, commit, or PR.

```text
Review this requirement.

Requirement locator:
<paste the requirement title, slug, branch, path, issue link, PR link, or any known context here>

Review focus:
<paste "requirement fit", "implementation quality", "validation", "handoff readiness", "all", or specific concerns here>

Use this project's installed AI instructions. Start with `ai/workflows/requirement-planning.md` to read the requirement workspace and understand the current state.

Use `ai/workflows/code-review.md` for the review lens. Use `ai/workflows/ci-validation.md` and `ai/workflows/wiki-documentation.md` when validation or durable documentation is part of the review.

Lead with findings that could affect correctness, scope, validation, handoff safety, or maintainability. Include file/path references when available. If no issues are found, say that clearly and note any remaining risk or validation gap.

Do not implement fixes unless I explicitly ask. If a decision would change scope, validation, rollout, or risk, use the installed interview-question guidance and include your recommended default.
```

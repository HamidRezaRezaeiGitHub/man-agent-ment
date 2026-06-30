# Prompt: Start Requirement

Use this in a project with installed AI workflow instructions when a fresh agent session should start a new requirement and continue through implementation.

```text
Start a new requirement.

Requirement:
<describe the requirement, context, constraints, acceptance criteria, links, or notes here>

Use this project's installed AI instructions. Start with `ai/workflows/workflow-dispatch.md`, then follow `ai/workflows/requirement-planning.md`.

If the request is vague or outcome-oriented, use `ai/workflows/vibe-coding-translation.md` before source discovery.

If a decision would change scope, implementation, validation, rollout, or risk, use the installed interview-question guidance and include your recommended default. Otherwise, make reasonable assumptions, record them in the requirement workspace, and continue.

After the plan is clear enough, implement the requirement. Before finishing, use `ai/workflows/ci-validation.md`, `ai/workflows/code-review.md`, and `ai/workflows/wiki-documentation.md` as applicable.
```

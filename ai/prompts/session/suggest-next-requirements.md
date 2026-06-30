# Prompt: Suggest Next Requirements

Use this in a project with installed AI workflow instructions when an agent should inspect local context and suggest useful next requirement candidates.

```text
Suggest next requirements.

Goal or area:
<paste a product area, repo area, milestone, quality goal, user problem, or "overall project health" here>

Constraints:
<paste priority, risk tolerance, time budget, excluded areas, or "none known" here>

Use this project's installed AI instructions. Start with `ai/workflows/workflow-dispatch.md` and use `ai/workflows/requirement-planning.md` to inspect existing local requirement workspaces before suggesting new ones.

Use the project wiki and narrow docs/source context only where it helps avoid duplicate or poorly scoped suggestions. Prefer suggestions that are concrete enough to become requirement titles with a short rationale, expected value, likely validation, and any known dependency or risk.

Do not create new requirement workspaces unless I explicitly choose one. If prioritization depends on missing product or risk decisions, use the installed interview-question guidance and include your recommended default.
```

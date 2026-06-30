# Prompt: Shape Requirement From Keywords

Use this in a project with installed AI workflow instructions when the user only has keywords, symptoms, feature names, or rough notes.

```text
Shape a requirement from these clues.

Keywords or rough notes:
<paste keywords, symptoms, feature names, file paths, errors, stakeholder phrases, or partial ideas here>

Known constraints:
<paste deadlines, risk boundaries, out-of-scope areas, preferred direction, or "none known" here>

Use this project's installed AI instructions. Start with `ai/workflows/workflow-dispatch.md`.

Treat the input as incomplete. Do a light context pass using the project wiki and narrow source/docs areas suggested by the clues. If the request is outcome-oriented or ambiguous, use `ai/workflows/vibe-coding-translation.md`.

Use the installed interview-question guidance more aggressively than usual. Ask a concise round of decision-shaping questions with recommended defaults before implementation. Prefer questions that clarify user intent, acceptance criteria, constraints, risk, and validation. Do not ask questions that local context already answered.

Once the requirement is concrete enough, follow `ai/workflows/requirement-planning.md`. Record the inferred requirement, assumptions, user answers, and remaining risks before implementation.

Before finishing, use `ai/workflows/ci-validation.md`, `ai/workflows/code-review.md`, and `ai/workflows/wiki-documentation.md` as applicable.
```

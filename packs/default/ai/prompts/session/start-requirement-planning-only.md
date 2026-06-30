# Prompt: Start Requirement Planning Only

Use this in a project with installed AI workflow instructions when a fresh agent session should plan a new requirement but not implement it yet.

```text
Start requirement planning only. Do not implement the requirement in this session unless I explicitly ask afterward.

Requirement:
<describe the requirement, context, constraints, acceptance criteria, links, or notes here>

Use this project's installed AI instructions. Start with `ai/workflows/workflow-dispatch.md`, then follow `ai/workflows/requirement-planning.md`.

If the request is vague or outcome-oriented, use `ai/workflows/vibe-coding-translation.md` before source discovery.

Use the installed interview-question guidance for decisions that would change scope, validation, rollout, or risk. Include your recommended default with each question.

Create or update the requirement workspace, capture assumptions and open questions, identify likely validation, and stop after leaving the plan ready for a future implementation session.
```

# Prompt: Analyze Requirements Stats

Use this in a project with installed AI workflow instructions when an agent should summarize the local requirement workspace inventory.

```text
Analyze requirement statistics.

Scope:
<paste "all local requirements", a status/category, a date range, a branch, a folder path, or "default" here>

Questions to answer:
<paste specific questions, or "summarize status distribution, stale work, blockers, and completion trends">

Use this project's installed AI instructions. Start with `ai/workflows/requirement-planning.md` and inspect local requirement workspaces only as much as needed.

Summarize counts by status/category, notable stale or blocked requirements, recently active work, and any validation or handoff gaps visible from the requirement files. Avoid broad source discovery unless a requirement file points to a specific area that must be checked.

Do not modify requirement files unless I explicitly ask. If the analysis depends on an ambiguous interpretation, use the installed interview-question guidance and include your recommended default.
```

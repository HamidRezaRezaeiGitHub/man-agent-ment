---
name: requirement-planning
use_when: Starting or resuming a standard, large, or risky requirement, feature, bug fix, refactor, investigation, or multi-step documentation task.
---

# Requirement Planning Workflow

Use this workflow at the beginning of any non-trivial requirement, feature, bug fix, refactor, investigation, or multi-step documentation task.
This behavior is a workflow instruction plus automation.

## First Agent Responsibilities

- Before running the script, evaluate the current branch and working tree, and clarify with the user when the situation is ambiguous:
  - Run `git branch --show-current` and `git status --short` to see the starting state.
  - If the user is already on a feature/topic branch unrelated to this requirement, ask whether to switch off it, continue this requirement on the existing branch, or commit/stash first.
  - If the working tree has uncommitted changes, surface this to the user, and confirm whether to commit, stash, or stay on the current branch.
  - If untracked files exist, decide whether they should be committed, stashed, removed, ignored, or intentionally carried before proceeding. Untracked files can confuse handoff and validation.
  - Skip above questions when the current branch is `main`/`master` with a clean tree.
- Run the script:
  ```sh
  ai/scripts/start-requirement.sh "Requirement Title"
  ```
- Here are the script behaviors:
  - Converts the title to a slug, i.e. lowercase, spaces to hyphens, remove punctuation except hyphens, and collapse repeated hyphens.
  - Creates or reuses `requirements/<slug>/` as the shared local workspace for this requirement. The script keeps `requirements/` ignored by default so PLAN.md and FINDINGS.md stay local, while agents on the same machine can collaborate through the same files.
  - Creates or updates `requirements/<slug>/PLAN.md` and `requirements/<slug>/FINDINGS.md` from templates.
  - Creates or switches to the expected branch, preferring `feature/<slug>` when possible.
  - Aborts before switching when the working tree is dirty, and warns when switching from a non-main feature/topic branch.
  - Warns before switching when untracked files are present, but does not fail solely because of untracked files.
- Each non-quick requirement should have a local workspace, and implementation work should not happen directly on `main` or `master`.
- If the requirement workspace already exists, or the script output indicates it was reused, follow the resuming responsibilities below.
- Read the generated `PLAN.md` template.
- Record complexity.
- Read project orientation, related wiki pages, and source code only when needed for context. Follow `Research And Context Optimization` below.

## Resuming Agent Responsibilities

- Read `requirements/<slug>/PLAN.md` first.
- Read `requirements/<slug>/FINDINGS.md` before wiki, docs, or source discovery.
- Check the current branch against the expected branch recorded in `PLAN.md`.
- Run `git status --short --branch` and inspect relevant uncommitted changes before editing.
- You may run the same requirement command again to re-check branch and file setup, but use `--stay-on-current-branch` to avoid an unsafe branch switch:
  ```sh
  ai/scripts/start-requirement.sh --stay-on-current-branch "Requirement Title"
  ```
- If the branch or files are not set up as expected, investigate and fix the issue before proceeding. Do not continue without a clear workspace setup.
- Read recent diffs, commits, handoff notes, and the next unfinished checklist item before broad source search.
- Avoid redoing completed research or implementation unless the plan says it is stale, blocked, or suspect.
- Update the plan status and `last_modified` metadata before substantial follow-on work.
- Append decisions, blockers, validation results, review notes, and handoff notes as work progresses.

Treat this as a resume-session checklist, not as permission to re-run full requirement planning from scratch. If the existing plan is too sparse or stale to guide safe work, refresh only the missing sections and explain why.

## All Agents Responsibilities

- Identify and run a safe, reasonably scoped baseline verification. Follow `Baseline Verification At Start` below.
- Ask proportional clarifying questions only for decisions that remain unresolved after the context pass. Follow `ai/skills/interview-questions/SKILL.md`.
- Treat `requirements/<slug>/PLAN.md` and `FINDINGS.md` as live handoff artifacts. Another agent may resume the requirement, or pick up a parallel-safe task, at any time.
- Fill in the useful parts of `PLAN.md`.
- If the handoff state becomes stale or sparse, use `ai/skills/handoff/SKILL.md` to normalize the requirement workspace before stopping or before resuming after a gap.
- If the request needs vibe-coding translation, use `ai/workflows/vibe-coding-translation.md`, record the concrete translation, acceptance criteria, assumptions, and remaining open questions in `PLAN.md`.
- If the request affects boundaries, contracts, data flow, integrations, persistence, public APIs, cross-cutting concerns, security, privacy, or long-term maintainability, consult `ai/workflows/architecture.md` and record the architecture impact in `PLAN.md`.
- Before substantial implementation, update the plan status so another agent can tell whether the work is planning, active, validating, reviewing, blocked, parked, complete, or cancelled.
- Keep detailed reusable context in `FINDINGS.md`; keep `PLAN.md` focused on current status and next actions. See `FINDINGS.md Expectations` below.

## Research And Context Optimization

- Start from `PLAN.md` and then `FINDINGS.md` before scanning source code.
- When resuming, identify the next unfinished checklist item or handoff note before opening broad source areas.
- Use `FINDINGS.md` as the requirement-specific context cache and filter for wiki/source lookup.
- Read `wiki/index.md` and relevant wiki pages.
- Consult architecture docs and `ai/workflows/architecture.md` for architecture-sensitive work.
- Read documented architecture, testing, CI, and command references before broad code search.
- Search source code only for the part of the requirement being worked on, or similar code areas identified.

## Baseline Verification At Start

1. Look for an existing validation command in `AGENTS.md`, `README`, contribution docs, `wiki/`, CI files, package scripts, build files, or task runners.
2. Choose the smallest meaningful baseline that proves the current workspace starts from a known state. Prefer targeted smoke checks over full suites when full validation is slow or noisy.
3. Record the command and result in `PLAN.md`.
4. If the baseline fails before any source edits, document it as pre-existing in `PLAN.md` and add useful details to `FINDINGS.md`.
5. If no baseline can be run locally, record why and what CI or manual check would provide equivalent confidence.

If the requirement is to fix the failing baseline or another observed defect, follow `ai/workflows/systematic-debugging.md` before proposing the fix.

## PLAN.md Expectations

`PLAN.md` should stay useful for a human and for any future agent. Keep it concise but current.

Treat it as a live control surface, not a static summary written only at the end. Another agent should be able to open it and continue safely.

The template is a starting point, not a fixed schema. Agents may add, remove, merge, or rename sections to fit the requirement, as long as Markdown remains readable and any project linting still passes.

For standard to risky requirements, break implementation into phases. Each phase should have a concrete goal, verifiable steps, and a done condition explicit enough to hand off to a developer. Phases make it safe for another agent to pick up where the previous one stopped.

Prefer sections that answer:

- What is the request?
- What complexity and workflows apply?
- What is included, out of scope, assumed, or still open?
- What context was checked, and where is deeper reusable context recorded?
- What baseline verification was run before source edits?
- What is the current plan, status, and next action?
- What phases does implementation break into, and what is the verifiable done condition for each?
- What progress has already been made?
- What worked, what did not work, and what should not be retried blindly?
- What decisions, validation results, review notes, blockers, or handoff notes matter?
- What task slice, if any, is safe for another agent to pick up in parallel?
- What durable project knowledge changed, and was it promoted to the wiki?

### Requirement Status

Use a concise status value in `PLAN.md` metadata. Recommended statuses are `planning`, `active`, `blocked`, `parked`, `complete`, and `cancelled`.

These statuses work with `ai/scripts/list-requirements.sh` and `ai/scripts/lint-requirements.sh`. The scripts also map common status variants into conceptual categories with case-insensitive substring matching, so values such as `completed`, `done`, `finished`, or `implemented` are treated as done.

## FINDINGS.md Expectations

`FINDINGS.md` should capture requirement-specific knowledge that is useful but too detailed for `PLAN.md`.

Treat it as the shared requirement context cache for future agents, not as a private scratchpad.

Use it for:

- relevant wiki/docs links and why they matter,
- relevant source files, classes, methods, tests, configs, or commands,
- user clarifications and back-and-forth decisions,
- investigation notes,
- what worked,
- what did not work or should not be retried blindly,
- risks and open questions,
- validation clues.

Follow `ai/workflows/wiki-documentation.md` alongside this workflow.
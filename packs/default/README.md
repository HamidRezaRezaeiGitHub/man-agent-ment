# Default Pack

Installable starter pack for adopting projects.

Files under this directory are source templates. `scripts/install-adapter.sh` maps them into each target project's expected native locations.

Preview an install without writing files:

```sh
scripts/install-adapter.sh --dry-run /path/to/target-project
```

## Target Mapping

- `root/AGENTS.md` -> `AGENTS.md`
- `root/CLAUDE.md` -> `CLAUDE.md`
- `root/GEMINI.md` -> `GEMINI.md`
- `root/.claude/settings.json` -> `.claude/settings.json`
- `root/.codex/hooks.json` -> `.codex/hooks.json`
- `root/.gemini/settings.json` -> `.gemini/settings.json`
- `root/.github/copilot-instructions.md` -> `.github/copilot-instructions.md`
- `root/.github/hooks/wiki-reminder.json` -> `.github/hooks/wiki-reminder.json`
- `root/.github/instructions/wiki.instructions.md` -> `.github/instructions/wiki.instructions.md`
- `root/.github/instructions/architecture.instructions.md` -> `.github/instructions/architecture.instructions.md`
- `root/.github/instructions/ci-validation.instructions.md` -> `.github/instructions/ci-validation.instructions.md`
- `root/.github/instructions/testing-quality.instructions.md` -> `.github/instructions/testing-quality.instructions.md`
- `root/.github/instructions/code-review.instructions.md` -> `.github/instructions/code-review.instructions.md`
- `root/.github/instructions/interview-questions.instructions.md` -> `.github/instructions/interview-questions.instructions.md`
- `claude/commands/start-requirement.md` -> `.claude/commands/start-requirement.md`
- `claude/skills/handoff/SKILL.md` -> `.claude/skills/handoff/SKILL.md`
- `claude/skills/interview-questions/SKILL.md` -> `.claude/skills/interview-questions/SKILL.md`
- `gemini/skills/handoff/SKILL.md` -> `.gemini/skills/handoff/SKILL.md`
- `gemini/skills/interview-questions/SKILL.md` -> `.gemini/skills/interview-questions/SKILL.md`
- `ai/README.md` -> `ai/README.md`
- `ai/pack.yaml` -> `ai/pack.yaml`
- `ai/skills/handoff/SKILL.md` -> `ai/skills/handoff/SKILL.md`
- `ai/skills/handoff/agents/openai.yaml` -> `ai/skills/handoff/agents/openai.yaml`
- `ai/skills/interview-questions/SKILL.md` -> `ai/skills/interview-questions/SKILL.md`
- `ai/skills/interview-questions/agents/openai.yaml` -> `ai/skills/interview-questions/agents/openai.yaml`
- `ai/prompts/session/start-requirement.md` -> `ai/prompts/session/start-requirement.md`
- `ai/prompts/session/start-requirement-planning-only.md` -> `ai/prompts/session/start-requirement-planning-only.md`
- `ai/prompts/session/continue-requirement.md` -> `ai/prompts/session/continue-requirement.md`
- `ai/prompts/session/shape-requirement-from-keywords.md` -> `ai/prompts/session/shape-requirement-from-keywords.md`
- `ai/prompts/session/review-requirement.md` -> `ai/prompts/session/review-requirement.md`
- `ai/prompts/session/analyze-requirements-stats.md` -> `ai/prompts/session/analyze-requirements-stats.md`
- `ai/workflows/workflow-dispatch.md` -> `ai/workflows/workflow-dispatch.md`
- `ai/workflows/requirement-planning.md` -> `ai/workflows/requirement-planning.md`
- `ai/workflows/wiki-documentation.md` -> `ai/workflows/wiki-documentation.md`
- `ai/workflows/architecture.md` -> `ai/workflows/architecture.md`
- `ai/workflows/command-execution.md` -> `ai/workflows/command-execution.md`
- `ai/workflows/systematic-debugging.md` -> `ai/workflows/systematic-debugging.md`
- `ai/workflows/ci-validation.md` -> `ai/workflows/ci-validation.md`
- `ai/workflows/testing-quality.md` -> `ai/workflows/testing-quality.md`
- `ai/workflows/code-review.md` -> `ai/workflows/code-review.md`
- `ai/workflows/vibe-coding-translation.md` -> `ai/workflows/vibe-coding-translation.md`
- `ai/templates/requirement/PLAN.md` -> `ai/templates/requirement/PLAN.md`
- `ai/templates/requirement/FINDINGS.md` -> `ai/templates/requirement/FINDINGS.md`
- `ai/templates/wiki/index.md` -> `ai/templates/wiki/index.md`
- `ai/templates/wiki/log.md` -> `ai/templates/wiki/log.md`
- `ai/templates/wiki/page.md` -> `ai/templates/wiki/page.md`
- `ai/scripts/start-requirement.sh` -> `ai/scripts/start-requirement.sh`
- `ai/scripts/requirement-status.sh` -> `ai/scripts/requirement-status.sh`
- `ai/scripts/list-requirements.sh` -> `ai/scripts/list-requirements.sh`
- `ai/scripts/lint-requirements.sh` -> `ai/scripts/lint-requirements.sh`
- `ai/scripts/audit-adoption.sh` -> `ai/scripts/audit-adoption.sh`
- `ai/scripts/wiki-lint.sh` -> `ai/scripts/wiki-lint.sh`
- `ai/scripts/wiki-reminder-context.sh` -> `ai/scripts/wiki-reminder-context.sh`
- `ai/scripts/wiki-reminder-hook.sh` -> `ai/scripts/wiki-reminder-hook.sh`
- `wiki/index.md` -> `wiki/index.md`
- `wiki/log.md` -> `wiki/log.md`
- `wiki/architecture/*.md` -> `wiki/architecture/*.md`
- `wiki/domain/ubiquitous-language.md` -> `wiki/domain/ubiquitous-language.md`
- `wiki/guides/testing.md` -> `wiki/guides/testing.md`

The `ai/scripts` target avoids colliding with a project's existing application scripts.

Session prompts under `packs/default/ai/prompts/session/` are copied into target projects as reusable prompt templates. Adoption prompts under `packs/default/ai/prompts/adoption/` are source-repo migration aids and are not copied into target projects.

`requirements/<slug>/` is local-only by default. `PLAN.md` and `FINDINGS.md` let agents on the same machine collaborate through the same local workspace. When cross-machine collaboration is needed, the user can intentionally force-add a single requirement folder in git.

The pack also installs a portable handoff skill that refreshes `requirements/<slug>/PLAN.md` and `FINDINGS.md` instead of creating a competing repo-root `HANDOFF.md`.

## Deterministic Wiki Reminder Hooks

The pack installs a shared reminder generator at `ai/scripts/wiki-reminder-context.sh` and a shared hook payload emitter at `ai/scripts/wiki-reminder-hook.sh` when the target project uses supported agent CLIs.

If an adopted project already has merge-sensitive hook or settings files such as `.claude/settings.json`, `.codex/hooks.json`, `.gemini/settings.json`, or `.github/hooks/wiki-reminder.json`, the installer will skip them, print a conflict warning, and require a manual merge instead of overwriting local configuration.

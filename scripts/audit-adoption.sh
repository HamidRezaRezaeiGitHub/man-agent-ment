#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
  echo "Usage: scripts/audit-adoption.sh /path/to/target-project" >&2
  exit 2
fi

target=$1
pack="packs/default"
status=0

if [ ! -d "$target" ]; then
  echo "Target directory does not exist: $target" >&2
  exit 1
fi

check_mapping() {
  source=$1
  destination=$2

  if [ ! -e "$target/$destination" ]; then
    echo "missing $destination"
    status=1
  elif cmp -s "$source" "$target/$destination"; then
    echo "ok      $destination"
  else
    echo "changed $destination"
  fi
}

check_mapping "$pack/root/AGENTS.md" "AGENTS.md"
check_mapping "$pack/root/CLAUDE.md" "CLAUDE.md"
check_mapping "$pack/root/GEMINI.md" "GEMINI.md"
check_mapping "$pack/root/.claude/settings.json" ".claude/settings.json"
check_mapping "$pack/root/.codex/hooks.json" ".codex/hooks.json"
check_mapping "$pack/root/.gemini/settings.json" ".gemini/settings.json"
check_mapping "$pack/root/.github/copilot-instructions.md" ".github/copilot-instructions.md"
check_mapping "$pack/root/.github/hooks/wiki-reminder.json" ".github/hooks/wiki-reminder.json"
check_mapping "$pack/root/.github/instructions/wiki.instructions.md" ".github/instructions/wiki.instructions.md"
check_mapping "$pack/root/.github/instructions/architecture.instructions.md" ".github/instructions/architecture.instructions.md"
check_mapping "$pack/root/.github/instructions/ci-validation.instructions.md" ".github/instructions/ci-validation.instructions.md"
check_mapping "$pack/root/.github/instructions/testing-quality.instructions.md" ".github/instructions/testing-quality.instructions.md"
check_mapping "$pack/root/.github/instructions/code-review.instructions.md" ".github/instructions/code-review.instructions.md"
check_mapping "$pack/root/.github/instructions/interview-questions.instructions.md" ".github/instructions/interview-questions.instructions.md"
check_mapping "$pack/claude/commands/start-requirement.md" ".claude/commands/start-requirement.md"
check_mapping "$pack/claude/skills/handoff/SKILL.md" ".claude/skills/handoff/SKILL.md"
check_mapping "$pack/claude/skills/interview-questions/SKILL.md" ".claude/skills/interview-questions/SKILL.md"
check_mapping "$pack/gemini/skills/handoff/SKILL.md" ".gemini/skills/handoff/SKILL.md"
check_mapping "$pack/gemini/skills/interview-questions/SKILL.md" ".gemini/skills/interview-questions/SKILL.md"
check_mapping "$pack/ai/README.md" "ai/README.md"
check_mapping "$pack/ai/pack.yaml" "ai/pack.yaml"
check_mapping "$pack/ai/skills/handoff/SKILL.md" "ai/skills/handoff/SKILL.md"
check_mapping "$pack/ai/skills/handoff/agents/openai.yaml" "ai/skills/handoff/agents/openai.yaml"
check_mapping "$pack/ai/skills/interview-questions/SKILL.md" "ai/skills/interview-questions/SKILL.md"
check_mapping "$pack/ai/skills/interview-questions/agents/openai.yaml" "ai/skills/interview-questions/agents/openai.yaml"
check_mapping "$pack/ai/prompts/session/start-requirement.md" "ai/prompts/session/start-requirement.md"
check_mapping "$pack/ai/prompts/session/start-requirement-planning-only.md" "ai/prompts/session/start-requirement-planning-only.md"
check_mapping "$pack/ai/prompts/session/continue-requirement.md" "ai/prompts/session/continue-requirement.md"
check_mapping "$pack/ai/prompts/session/shape-requirement-from-keywords.md" "ai/prompts/session/shape-requirement-from-keywords.md"
check_mapping "$pack/ai/prompts/session/review-requirement.md" "ai/prompts/session/review-requirement.md"
check_mapping "$pack/ai/prompts/session/analyze-requirements-stats.md" "ai/prompts/session/analyze-requirements-stats.md"
check_mapping "$pack/ai/prompts/session/suggest-next-requirements.md" "ai/prompts/session/suggest-next-requirements.md"
check_mapping "$pack/ai/workflows/workflow-dispatch.md" "ai/workflows/workflow-dispatch.md"
check_mapping "$pack/ai/workflows/requirement-planning.md" "ai/workflows/requirement-planning.md"
check_mapping "$pack/ai/workflows/wiki-documentation.md" "ai/workflows/wiki-documentation.md"
check_mapping "$pack/ai/workflows/architecture.md" "ai/workflows/architecture.md"
check_mapping "$pack/ai/workflows/command-execution.md" "ai/workflows/command-execution.md"
check_mapping "$pack/ai/workflows/systematic-debugging.md" "ai/workflows/systematic-debugging.md"
check_mapping "$pack/ai/workflows/ci-validation.md" "ai/workflows/ci-validation.md"
check_mapping "$pack/ai/workflows/testing-quality.md" "ai/workflows/testing-quality.md"
check_mapping "$pack/ai/workflows/code-review.md" "ai/workflows/code-review.md"
check_mapping "$pack/ai/workflows/vibe-coding-translation.md" "ai/workflows/vibe-coding-translation.md"
check_mapping "$pack/ai/templates/requirement/PLAN.md" "ai/templates/requirement/PLAN.md"
check_mapping "$pack/ai/templates/requirement/FINDINGS.md" "ai/templates/requirement/FINDINGS.md"
check_mapping "$pack/ai/templates/wiki/index.md" "ai/templates/wiki/index.md"
check_mapping "$pack/ai/templates/wiki/log.md" "ai/templates/wiki/log.md"
check_mapping "$pack/ai/templates/wiki/page.md" "ai/templates/wiki/page.md"
check_mapping "$pack/ai/scripts/wiki-reminder-context.sh" "ai/scripts/wiki-reminder-context.sh"
check_mapping "$pack/ai/scripts/wiki-reminder-hook.sh" "ai/scripts/wiki-reminder-hook.sh"
check_mapping "$pack/ai/scripts/start-requirement.sh" "ai/scripts/start-requirement.sh"
check_mapping "$pack/ai/scripts/requirement-status.sh" "ai/scripts/requirement-status.sh"
check_mapping "$pack/ai/scripts/list-requirements.sh" "ai/scripts/list-requirements.sh"
check_mapping "$pack/ai/scripts/lint-requirements.sh" "ai/scripts/lint-requirements.sh"
check_mapping "$pack/ai/scripts/audit-adoption.sh" "ai/scripts/audit-adoption.sh"
check_mapping "$pack/ai/scripts/wiki-lint.sh" "ai/scripts/wiki-lint.sh"
check_mapping "$pack/wiki/index.md" "wiki/index.md"
check_mapping "$pack/wiki/log.md" "wiki/log.md"
check_mapping "$pack/wiki/architecture/system-overview.md" "wiki/architecture/system-overview.md"
check_mapping "$pack/wiki/architecture/tech-stack.md" "wiki/architecture/tech-stack.md"
check_mapping "$pack/wiki/architecture/data-flow.md" "wiki/architecture/data-flow.md"
check_mapping "$pack/wiki/architecture/integration-points.md" "wiki/architecture/integration-points.md"
check_mapping "$pack/wiki/architecture/decisions.md" "wiki/architecture/decisions.md"
check_mapping "$pack/wiki/domain/ubiquitous-language.md" "wiki/domain/ubiquitous-language.md"
check_mapping "$pack/wiki/guides/testing.md" "wiki/guides/testing.md"

exit "$status"

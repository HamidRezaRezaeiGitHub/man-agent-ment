#!/bin/sh
set -eu

usage() {
  cat >&2 <<'USAGE'
Usage: scripts/install-adapter.sh [--dry-run] /path/to/target-project

Options:
  --dry-run, -n  Show planned creates, skips, and chmods without writing files.
USAGE
}

dry_run=0
target=

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run|-n)
      dry_run=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --*)
      echo "unknown option: $1" >&2
      usage
      exit 2
      ;;
    *)
      if [ -n "$target" ]; then
        echo "unexpected argument: $1" >&2
        usage
        exit 2
      fi
      target=$1
      ;;
  esac
  shift
done

if [ -z "$target" ]; then
  usage
  exit 2
fi

if [ ! -d "$target" ]; then
  echo "Target directory does not exist: $target" >&2
  exit 1
fi

pack="packs/default"
created_count=0
skipped_count=0
chmod_count=0
manual_merge_conflicts=''

ensure_directories() {
  if [ "$dry_run" -eq 1 ]; then
    echo "would ensure required directories under $target"
  else
    mkdir -p \
      "$target/.github/hooks" \
      "$target/.github/instructions" \
      "$target/.claude/commands" \
      "$target/.claude/skills/handoff" \
      "$target/.claude/skills/interview-questions" \
      "$target/.codex" \
      "$target/.gemini" \
      "$target/.gemini/skills/handoff" \
      "$target/.gemini/skills/interview-questions" \
      "$target/ai/skills/handoff/agents" \
      "$target/ai/workflows" \
      "$target/ai/skills/interview-questions/agents" \
      "$target/ai/prompts/session" \
      "$target/ai/templates/requirement" \
      "$target/ai/templates/wiki" \
      "$target/ai/scripts" \
      "$target/wiki/architecture" \
      "$target/wiki/domain" \
      "$target/wiki/guides"
  fi
}

is_manual_merge_file() {
  case "$1" in
    "$target/.claude/settings.json"|"$target/.codex/hooks.json"|"$target/.gemini/settings.json"|"$target/.github/hooks/wiki-reminder.json")
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

copy_if_missing() {
  source=$1
  destination=$2

  if [ -e "$destination" ]; then
    echo "skip existing $destination (not overwritten; review and migrate manually if the pack changed)"
    if is_manual_merge_file "$destination"; then
      echo "warning existing hook/settings file $destination requires a manual merge with $source"
      manual_merge_conflicts="${manual_merge_conflicts}${destination}\n"
    fi
    skipped_count=$((skipped_count + 1))
  elif [ "$dry_run" -eq 1 ]; then
    echo "would create $destination"
    created_count=$((created_count + 1))
  else
    cp "$source" "$destination"
    echo "created $destination"
    created_count=$((created_count + 1))
  fi
}

ensure_executable() {
  file=$1

  if [ "$dry_run" -eq 1 ]; then
    echo "would chmod +x $file"
  else
    chmod +x "$file"
  fi
  chmod_count=$((chmod_count + 1))
}

ensure_directories

copy_if_missing "$pack/root/AGENTS.md" "$target/AGENTS.md"
copy_if_missing "$pack/root/CLAUDE.md" "$target/CLAUDE.md"
copy_if_missing "$pack/root/GEMINI.md" "$target/GEMINI.md"
copy_if_missing "$pack/root/.claude/settings.json" "$target/.claude/settings.json"
copy_if_missing "$pack/root/.codex/hooks.json" "$target/.codex/hooks.json"
copy_if_missing "$pack/root/.gemini/settings.json" "$target/.gemini/settings.json"
copy_if_missing "$pack/root/.github/copilot-instructions.md" "$target/.github/copilot-instructions.md"
copy_if_missing "$pack/root/.github/hooks/wiki-reminder.json" "$target/.github/hooks/wiki-reminder.json"
copy_if_missing "$pack/root/.github/instructions/wiki.instructions.md" "$target/.github/instructions/wiki.instructions.md"
copy_if_missing "$pack/root/.github/instructions/architecture.instructions.md" "$target/.github/instructions/architecture.instructions.md"
copy_if_missing "$pack/root/.github/instructions/ci-validation.instructions.md" "$target/.github/instructions/ci-validation.instructions.md"
copy_if_missing "$pack/root/.github/instructions/testing-quality.instructions.md" "$target/.github/instructions/testing-quality.instructions.md"
copy_if_missing "$pack/root/.github/instructions/code-review.instructions.md" "$target/.github/instructions/code-review.instructions.md"
copy_if_missing "$pack/root/.github/instructions/interview-questions.instructions.md" "$target/.github/instructions/interview-questions.instructions.md"
copy_if_missing "$pack/ai/README.md" "$target/ai/README.md"
copy_if_missing "$pack/ai/pack.yaml" "$target/ai/pack.yaml"
copy_if_missing "$pack/ai/skills/handoff/SKILL.md" "$target/ai/skills/handoff/SKILL.md"
copy_if_missing "$pack/ai/skills/handoff/agents/openai.yaml" "$target/ai/skills/handoff/agents/openai.yaml"
copy_if_missing "$pack/ai/skills/interview-questions/SKILL.md" "$target/ai/skills/interview-questions/SKILL.md"
copy_if_missing "$pack/ai/skills/interview-questions/agents/openai.yaml" "$target/ai/skills/interview-questions/agents/openai.yaml"
copy_if_missing "$pack/ai/prompts/session/start-requirement.md" "$target/ai/prompts/session/start-requirement.md"
copy_if_missing "$pack/ai/prompts/session/start-requirement-planning-only.md" "$target/ai/prompts/session/start-requirement-planning-only.md"
copy_if_missing "$pack/ai/prompts/session/continue-requirement.md" "$target/ai/prompts/session/continue-requirement.md"
copy_if_missing "$pack/ai/prompts/session/shape-requirement-from-keywords.md" "$target/ai/prompts/session/shape-requirement-from-keywords.md"
copy_if_missing "$pack/ai/prompts/session/review-requirement.md" "$target/ai/prompts/session/review-requirement.md"
copy_if_missing "$pack/ai/prompts/session/analyze-requirements-stats.md" "$target/ai/prompts/session/analyze-requirements-stats.md"
copy_if_missing "$pack/ai/prompts/session/suggest-next-requirements.md" "$target/ai/prompts/session/suggest-next-requirements.md"
copy_if_missing "$pack/ai/workflows/workflow-dispatch.md" "$target/ai/workflows/workflow-dispatch.md"
copy_if_missing "$pack/ai/workflows/requirement-planning.md" "$target/ai/workflows/requirement-planning.md"
copy_if_missing "$pack/ai/workflows/wiki-documentation.md" "$target/ai/workflows/wiki-documentation.md"
copy_if_missing "$pack/ai/workflows/architecture.md" "$target/ai/workflows/architecture.md"
copy_if_missing "$pack/ai/workflows/command-execution.md" "$target/ai/workflows/command-execution.md"
copy_if_missing "$pack/ai/workflows/systematic-debugging.md" "$target/ai/workflows/systematic-debugging.md"
copy_if_missing "$pack/ai/workflows/ci-validation.md" "$target/ai/workflows/ci-validation.md"
copy_if_missing "$pack/ai/workflows/testing-quality.md" "$target/ai/workflows/testing-quality.md"
copy_if_missing "$pack/ai/workflows/code-review.md" "$target/ai/workflows/code-review.md"
copy_if_missing "$pack/ai/workflows/vibe-coding-translation.md" "$target/ai/workflows/vibe-coding-translation.md"
copy_if_missing "$pack/ai/templates/requirement/PLAN.md" "$target/ai/templates/requirement/PLAN.md"
copy_if_missing "$pack/ai/templates/requirement/FINDINGS.md" "$target/ai/templates/requirement/FINDINGS.md"
copy_if_missing "$pack/ai/templates/wiki/index.md" "$target/ai/templates/wiki/index.md"
copy_if_missing "$pack/ai/templates/wiki/log.md" "$target/ai/templates/wiki/log.md"
copy_if_missing "$pack/ai/templates/wiki/page.md" "$target/ai/templates/wiki/page.md"
copy_if_missing "$pack/ai/scripts/wiki-reminder-context.sh" "$target/ai/scripts/wiki-reminder-context.sh"
copy_if_missing "$pack/ai/scripts/wiki-reminder-hook.sh" "$target/ai/scripts/wiki-reminder-hook.sh"
copy_if_missing "$pack/wiki/index.md" "$target/wiki/index.md"
copy_if_missing "$pack/wiki/log.md" "$target/wiki/log.md"
copy_if_missing "$pack/wiki/architecture/system-overview.md" "$target/wiki/architecture/system-overview.md"
copy_if_missing "$pack/wiki/architecture/tech-stack.md" "$target/wiki/architecture/tech-stack.md"
copy_if_missing "$pack/wiki/architecture/data-flow.md" "$target/wiki/architecture/data-flow.md"
copy_if_missing "$pack/wiki/architecture/integration-points.md" "$target/wiki/architecture/integration-points.md"
copy_if_missing "$pack/wiki/architecture/decisions.md" "$target/wiki/architecture/decisions.md"
copy_if_missing "$pack/wiki/domain/ubiquitous-language.md" "$target/wiki/domain/ubiquitous-language.md"
copy_if_missing "$pack/wiki/guides/testing.md" "$target/wiki/guides/testing.md"
copy_if_missing "$pack/ai/scripts/start-requirement.sh" "$target/ai/scripts/start-requirement.sh"
copy_if_missing "$pack/ai/scripts/requirement-status.sh" "$target/ai/scripts/requirement-status.sh"
copy_if_missing "$pack/ai/scripts/list-requirements.sh" "$target/ai/scripts/list-requirements.sh"
copy_if_missing "$pack/ai/scripts/lint-requirements.sh" "$target/ai/scripts/lint-requirements.sh"
copy_if_missing "$pack/ai/scripts/audit-adoption.sh" "$target/ai/scripts/audit-adoption.sh"
copy_if_missing "$pack/ai/scripts/wiki-lint.sh" "$target/ai/scripts/wiki-lint.sh"
copy_if_missing "$pack/claude/commands/start-requirement.md" "$target/.claude/commands/start-requirement.md"
copy_if_missing "$pack/claude/skills/handoff/SKILL.md" "$target/.claude/skills/handoff/SKILL.md"
copy_if_missing "$pack/claude/skills/interview-questions/SKILL.md" "$target/.claude/skills/interview-questions/SKILL.md"
copy_if_missing "$pack/gemini/skills/handoff/SKILL.md" "$target/.gemini/skills/handoff/SKILL.md"
copy_if_missing "$pack/gemini/skills/interview-questions/SKILL.md" "$target/.gemini/skills/interview-questions/SKILL.md"

ensure_executable "$target/ai/scripts/start-requirement.sh"
ensure_executable "$target/ai/scripts/wiki-reminder-context.sh"
ensure_executable "$target/ai/scripts/wiki-reminder-hook.sh"
ensure_executable "$target/ai/scripts/list-requirements.sh"
ensure_executable "$target/ai/scripts/lint-requirements.sh"
ensure_executable "$target/ai/scripts/audit-adoption.sh"
ensure_executable "$target/ai/scripts/wiki-lint.sh"

if [ "$dry_run" -eq 1 ]; then
  echo "Dry run complete. No files were changed."
else
  echo "Done. Customize TODOs in the target project's agent instruction files."
fi
if [ "$skipped_count" -gt 0 ]; then
  echo "Existing files were skipped. Review the skip existing lines and manually migrate any pack updates that should apply."
fi
if [ -n "$manual_merge_conflicts" ]; then
  printf '%b' "$manual_merge_conflicts" \
    | sed '/^[[:space:]]*$/d' \
    | while IFS= read -r path; do
        echo "warning manual-merge-conflict $path"
      done
fi
echo "Summary: created=$created_count skipped=$skipped_count chmods=$chmod_count"

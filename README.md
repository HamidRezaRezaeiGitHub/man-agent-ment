# man-agent-ment

`man-agent-ment` is a portable AI-agent operating pack for software projects.

It gives Codex, Claude Code, GitHub Copilot, Gemini, and similar coding agents a shared way to start requirements, preserve context, consult a project wiki, run validation, review changes, and hand work off between sessions without re-discovering the same information over and over.

The guiding rule is simple: keep durable behavior in reusable workflows, then expose only short pointers through each agent's native instruction files.

## What You Get

- A lightweight dispatcher that classifies work as `quick`, `standard`, `large`, or `risky` so small edits do not become process-heavy.
- Local-only requirement workspaces under `requirements/<slug>/`, with `PLAN.md` for status and `FINDINGS.md` for reusable requirement-specific context. Agents on the same machine can share that local workspace; when cross-machine collaboration is needed, the user can intentionally force-add a single requirement folder in git.
- A project wiki pattern that lets agents start from stable documentation before scanning source code.
- Vibe-coding translation so stakeholder language becomes concrete acceptance criteria before implementation.
- Ubiquitous-language guidance so domain terms stay consistent across prompts, wiki pages, tests, and code discussion.
- Systematic debugging guidance for reproducing, localizing, fixing, and verifying defects without guess-and-check loops.
- Baseline verification before source edits when a safe project command exists.
- CI, testing, command-output, architecture, and two-pass code-review workflows.
- Installed session prompt templates for starting, planning, resuming, shaping, reviewing, and analyzing requirements without retyping workflow trigger phrases.
- Adoption prompts for clean projects, existing projects with current AI instructions, temporary install review, and pack updates.

## Why This Exists

Modern coding agents are powerful, but they often fail in familiar ways:

- they over-read the repo and burn tokens,
- they skip planning or ask too many questions,
- they forget discoveries between sessions,
- they use inconsistent domain language,
- they claim completion without enough validation,
- they hit rate limits or token limits,
- they review code for style while missing requirement mismatch.

This pack turns those lessons into small, inspectable project files. It aims to be disciplined without becoming ceremonial.

## Adoption

For adoption planning, use these prepared prompts from this source repository:

- [Adopt pack](./packs/default/ai/prompts/adoption/adopt-pack.md): first-time adoption into a target project, with or without existing agent instructions.
- [Update pack](./packs/default/ai/prompts/adoption/update-pack.md): update a target project that already has an older installed `ai/pack.yaml`.

These prompts are source-repo migration aids. Paste them into an agent session running in the target project; they tell the agent to clone this repo into a temporary folder inside that target project, inspect installer behavior, analyze the project, and prepare a staged migration plan. They are not copied into target projects.

Audit an adopted project from this repo:

```sh
scripts/audit-adoption.sh /path/to/target-project
```

Or from inside the adopted project:

```sh
ai/scripts/audit-adoption.sh
```

The central audit reports customized files as `changed` without failing. Missing files and self-audit failures should be investigated.

## Idea Lineage

This pack intentionally borrows from widely shared agent-engineering ideas, adapted into a portable project pack:

| Source | Adoption | Details |
| --- | ---: | --- |
| [Andrej Karpathy's LLM wiki idea](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) | ~80% | [Assessment](./ai/docs/idea-lineage/karpathy-llm-wiki.md) |
| [mattpocock/skills](https://github.com/mattpocock/skills) | ~65% | [Assessment](./ai/docs/idea-lineage/mattpocock-skills.md) |
| [Matt Pocock's Grill Me writeup](https://www.aihero.dev/my-grill-me-skill-has-gone-viral) | ~80% | [Assessment](./ai/docs/idea-lineage/matt-pocock-grill-me.md) |
| [Superpowers by Jesse Vincent](https://github.com/obra/superpowers) | ~65% | [Assessment](./ai/docs/idea-lineage/superpowers.md) |
| [Cline Memory Bank](https://docs.cline.bot/features/memory-bank) | ~85% | [Assessment](./ai/docs/idea-lineage/cline-memory-bank.md) |
| [Aider](https://github.com/Aider-AI/aider) | ~45% | [Assessment](./ai/docs/idea-lineage/aider.md) |
| [OpenHands](https://github.com/OpenHands/OpenHands) | ~35% | [Assessment](./ai/docs/idea-lineage/openhands.md) |
| [SWE-agent](https://github.com/SWE-agent/SWE-agent) | ~40% | [Assessment](./ai/docs/idea-lineage/swe-agent.md) |
| [MetaGPT](https://github.com/geekan/MetaGPT) and [ChatDev](https://github.com/OpenBMB/ChatDev) | ~50% | [Assessment](./ai/docs/idea-lineage/metagpt-chatdev.md) |
| [GitHub Agentic Workflows](https://github.github.com/gh-aw/) | ~45% | [Assessment](./ai/docs/idea-lineage/github-agentic-workflows.md) |
| [Domain-Driven Design by Eric Evans](https://www.domainlanguage.com/ddd/) | ~45% | [Assessment](./ai/docs/idea-lineage/domain-driven-design.md) |

The result is not a clone of any one system. It is a practical synthesis: enough process to keep agents aligned, but with routing rules that keep quick work quick.

---
name: skillopt-self-improvement
description: "Improve the system-cli-subagents skill docs with a SkillOpt-style loop: collect failure cases, edit skill text, validate with freebuff2api dry-runs, and promote only validated improvements."
---

# SkillOpt Self-Improvement

Use this skill when the user wants `system-cli-subagents` to get better over time through
trajectory-driven edits and validation-gated updates.

## Goal

- Improve `freebuff-worker-bridge/SKILL.md` and related skill text.
- Keep `skillopt/best_skill.md` as the promoted candidate.
- Preserve the real fallback path when MCP tools are not attached.

## Loop

1. Collect concrete failures, corrections, or confusing outputs.
2. Edit the smallest relevant skill text.
3. Check that the edit is shorter, clearer, or more accurate.
4. Validate with a dry-run of `invoke-freebuff-worker.ps1`.
5. Promote the change only if validation still passes and no unsupported claim was introduced.

## Acceptance rules

- Keep prompts compact.
- Keep the fallback script visible.
- Do not claim native subagent behavior for external CLI tools.
- Do not add multi-account or quota-bypass promises.

## Promotion target

- Treat `skillopt/best_skill.md` as the current best deployable skill text.
- When a new version wins, copy the validated instructions into the promoted file and then sync
  the plugin copy.

## What to read

- `skillopt/README.md`
- `skillopt/best_skill.md`
- `skills/freebuff-worker-bridge/SKILL.md`

# Freebuff Worker Bridge

Use this skill when Codex should offload research, drafting, or code exploration to the local `freebuff2api` service and then integrate the returned result.

## v1 contract

- Support a single upstream account already managed inside `freebuff2api`.
- Call `freebuff_delegate` when the MCP tool is available.
- Do not claim a native subagent runtime.
- If the MCP tool is not attached in the current thread, use the fallback script:

```powershell
pwsh -NoLogo -NoProfile -File "C:\Users\vaoferi\Documents\Codex\2026-06-11\new-chat\work\plugins\system-cli-subagents\scripts\invoke-freebuff-worker.ps1" `
  -Profile research `
  -Task "..." `
  -Context "..."
```

## Preferred payload

- `task`
- `context`
- `profile`
- `model_strategy`
- `model`
- `base_url`
- `api_key`
- `timeout_seconds`
- `max_tokens`
- `dry_run`

## Output contract

- Prefer compact JSON.
- Keep `summary` short.
- Keep `findings`, `next_steps`, `risks`, and `open_questions` concrete.
- When `dry_run=true`, return only the planned request, not a worker call.

## Guardrails

- Do not promise multi-account rotation.
- Do not promise quota bypass.
- Do not promise visible terminal flow.
- Do not hide that the fallback script exists.
- Keep prompts short so the worker does the heavy reasoning.

## Validation

- Dry-run must return structured JSON.
- Live worker calls must be checked against the actual `/v1/models` and `/v1/chat/completions` behavior.
- If the current thread cannot attach the MCP tool, prefer the fallback script over pretending it is missing.

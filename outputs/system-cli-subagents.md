# Freebuff Worker Bridge

## Що зроблено

- Створено локальний Codex plugin: `system-cli-subagents`
- Плагін лежить тут: `C:\Users\vaoferi\.agents\plugins\system-cli-subagents`
- Для scratch/debug лишився дубль у `C:\Users\vaoferi\Documents\Codex\2026-06-11\new-chat\work\plugins\system-cli-subagents`
- Local marketplace для видимості в Codex UI: `C:\Users\vaoferi\.agents\plugins\marketplace.json`
- Marketplace policy: `INSTALLED_BY_DEFAULT`
- Plugin version: `0.2.2+codex.20260611181621`
- Додано launcher/bridge script: `scripts/invoke-freebuff-worker.ps1`
- Залишено compatibility wrapper: `scripts/invoke-system-cli-agent.ps1`
- Додано skill для worker bridge: `skills/freebuff-worker-bridge/SKILL.md`
- Додано connectable MCP tool: `freebuff_delegate`

## Що підтримується у v1

- `freebuff2api`:
  - локальний HTTP bridge для одного робочого акаунта
  - автоматичний вибір моделі з доступних через `/v1/models`
  - передача задачі в компактному структурованому форматі
  - повернення короткого JSON-результату для Codex
  - MCP surface через `freebuff_delegate`

## Що не підтримується

- `openclaude` у v1 не використовується
- `opencode` у v1 не використовується
- native Codex subagent runtime для стороннього CLI не створюється
- multi-account rotation не використовується
- quota bypass або прихований batch-режим не обіцяються

## Перевірка

- `plugin.json` оновлено під `freebuff2api` worker bridge
- launcher script у dry-run повертає структурований JSON із вибраною моделлю
- bridge не намагається відкривати видимий термінал
- worker script пройшов mock HTTP roundtrip через `/v1/models` і `/v1/chat/completions`
- MCP tool `freebuff_delegate` листиться та викликається в dry-run через stdio client
- marketplace policy переведено на `INSTALLED_BY_DEFAULT`
- `openclaude` виключено з v1

## Примітка

Спроба запустити `codex plugin marketplace list` із shell вперлася в `Access is denied` для `codex.exe`, тому я залишив marketplace локально у workspace.

## Відкрити в Codex

- [View system-cli-subagents](codex://plugins/system-cli-subagents?marketplacePath=C%3A%5CUsers%5Cvaoferi%5C.agents%5Cplugins%5Cmarketplace.json)
- [Share system-cli-subagents](codex://plugins/system-cli-subagents?marketplacePath=C%3A%5CUsers%5Cvaoferi%5C.agents%5Cplugins%5Cmarketplace.json&mode=share)

## Як використати зараз

1. Відкрий `View system-cli-subagents`.
2. Якщо Codex попросить refresh, зроби reload/reopen один раз.
3. У наступному повідомленні пиши так:

```text
Use Freebuff Worker Bridge to: <твоя задача тут>
Return only compact JSON with summary, findings, next_steps, risks, open_questions.
```

## SkillOpt

- Поточний цикл покращення skill-доків: `skillopt/README.md`
- Поточний промотований текст: `skillopt/best_skill.md`
- Skill для запуску validation-gated loop: `.agents/plugins/system-cli-subagents/skills/skillopt-self-improvement/SKILL.md`

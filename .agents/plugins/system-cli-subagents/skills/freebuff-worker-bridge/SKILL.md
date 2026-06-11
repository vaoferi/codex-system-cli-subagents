---
name: freebuff-worker-bridge
description: Sends research and draft tasks to a local freebuff2api worker. This is not a native subagent.
---

# Freebuff Worker Bridge

Use this skill when Codex should offload research, drafting, or code exploration to the local `freebuff2api` service and then integrate the returned result.

## Як працює v1

- Підтримується один upstream account, який уже живе всередині `freebuff2api`.
- Codex не відкриває видимий термінал.
- Codex не створює native subagent.
- Bridge робить один HTTP-запит до `/v1/chat/completions` і отримує одну структуровану відповідь назад.
- Worker має повертати компактний JSON. Якщо треба більше роботи, Codex може зробити ще один виклик.

## Рекомендований виклик

```powershell
pwsh -NoLogo -NoProfile -File "C:\Users\vaoferi\Documents\Codex\2026-06-11\new-chat\.agents\plugins\system-cli-subagents\scripts\invoke-freebuff-worker.ps1" `
  -Profile research `
  -Task "Опиши, як краще реалізувати цей feature" `
  -Context "Сфокусуйся на мінімальних змінах і реальних файлах"
```

Для dry-run без мережевого виклику:

```powershell
pwsh -NoLogo -NoProfile -File "C:\Users\vaoferi\Documents\Codex\2026-06-11\new-chat\.agents\plugins\system-cli-subagents\scripts\invoke-freebuff-worker.ps1" `
  -Profile research `
  -Task "Dry run" `
  -DryRun
```

## Що очікувати

- Script автоматично читає `/v1/models`, якщо локальний service доступний.
- Модель вибирається автоматично за профілем і тим, що реально є в endpoint.
- Результат повертається як JSON, щоб Codex міг мінімально витрачати токени на читання.

## Що не обіцяти

- Не обіцяй native Codex subagent runtime.
- Не обіцяй multi-account load balancing.
- Не обіцяй bypass квот або лімітів.
- Не обіцяй hidden terminal flow.

## Перед запуском

- Переконайся, що локальний `freebuff2api` service доступний.
- Якщо на service увімкнено auth, переконайся, що `FREEBUFF_API_KEY` задано.
- Якщо service на іншому host або порту, вистав `FREEBUFF_API_BASE_URL`.

# Project Log

## 2026-06-11

- Задача: Freebuff Side-Terminal V1.
- Знайдено: у системі є `freebuff`; `openclaude` тимчасово виключено з v1; `opencode` не входить у цю версію.
- Змінено: plugin, skill, launcher, SPEC і user-facing output переведено на `freebuff`-only ручну інтерактивну сесію з пріоритетом Windows Terminal.
- Чому так: у v1 потрібен видимий термінал із ручним вибором моделі, без prompt automation і без native subagent runtime.
- Перевірено: `freebuff --help`, `Get-Command freebuff`, `Get-Command wt`, dry-run launcher, реальний запуск launcher з `processId`, оновлення manifest/skill/script/документації.
- Ризики: Windows Terminal split-pane контракт на цій збірці повернув `0x80070002`, тому стабільний шлях зараз іде через `wt.exe new-tab`; автоматизацію треба буде додавати окремо після підтвердженого машинного контракту.

- Задача: Freebuff Worker Bridge V1.
- Знайдено: `XxxXTeam/freebuff2api` вже дає OpenAI-compatible bridge і підтримує один активний upstream account як основу для worker-режиму.
- Змінено: scope переведено з видимого термінала на локальний `freebuff2api` worker bridge; Codex тепер має отримувати компактний JSON-результат, а не керувати інтерактивною сесією.
- Чому так: один робочий акаунт краще підходить для оффлоаду чорнової роботи, а Codex має залишатися оркестратором із мінімальною витратою токенів.
- Перевірено: README і код `freebuff2api` на GitHub, локальний plugin scaffold, поточний manifest/skill/script/docs перед змінами, `validate_plugin.py`, PowerShell syntax parse для worker/wrapper, dry-run worker bridge, mock HTTP roundtrip через `/v1/models` і `/v1/chat/completions`, update_plugin_cachebuster.py, повторний version bump для cache refresh, publish-ready usage block у `outputs/system-cli-subagents.md`.
- Ризики: runtime сервісу може бути вимкнений або вимагати `FREEBUFF_API_KEY`; auto-select моделі залежить від того, що реально повертає `/v1/models`.

- Задача: Plugin attach-path fix.
- Знайдено: Codex на цій машині читає personal marketplace з `C:\Users\vaoferi\.agents\plugins\marketplace.json`, тому `work/` і workspace-root mirror були недостатні для UI-видимості.
- Змінено: додано home-profile mirror у `C:\Users\vaoferi\.agents\plugins\system-cli-subagents` з тим самим manifest і wrapper-сценаріями, а marketplace policy переведено на `INSTALLED_BY_DEFAULT`, щоб Codex UI міг підхопити plugin без ручного install.
- Чому так: саме `~/.agents` є реальним attach-point для personal marketplace, а не workspace scratch copies.
- Перевірено: логічна відповідність marketplace source path `./plugins/system-cli-subagents` до фактичного plugin root під `C:\Users\vaoferi\.agents\plugins\system-cli-subagents`.
- Ризики: без live UI refresh/reopen може знадобитися один reload, але файлова інсталяція вже в правильному місці.

- Задача: Freebuff Worker Bridge MCP attach fix.
- Знайдено: плагін був видимий у personal marketplace, але не мав connectable runtime surface; `freebuff_delegate` був відсутній, тому UI бачив лише shell без tool attach.
- Змінено: додано локальний MCP server `scripts/freebuff_mcp_server.py`, companion `.mcp.json`, оновлено `plugin.json` з `mcpServers`, переписано skill під MCP tool, і синхронізовано це в `C:\Users\vaoferi\.agents\plugins\system-cli-subagents`.
- Чому так: Codex потрібен не лише видимий plugin shell, а реальний tool surface, який можна list/call у новому thread без ручних обхідних кроків.
- Перевірено: `validate_plugin.py` на workspace та personal root, live stdio smoke test через MCP client, `tools/list` показав `freebuff_delegate`, `tools/call` з `dry_run=true` повернув structuredContent без помилки.
- Ризики: для реального worker call локальний `freebuff2api` ще треба мати доступний на `FREEBUFF_API_BASE_URL`; поточний output у dry-run не робить мережевого виклику.

- Задача: Codex plugin attach root cause fix.
- Знайдено: `system-cli-subagents` був зареєстрований у personal marketplace, але source path вказував не на `C:\Users\vaoferi\.agents\plugins\system-cli-subagents`, тому Codex не міг коректно інсталювати плагін у cache/shadow layer для нового thread.
- Змінено: виправлено `C:\Users\vaoferi\.agents\plugins\marketplace.json` на реальний source path `./.agents/plugins/system-cli-subagents` і вручну синхронізовано plugin root у `C:\Users\vaoferi\.codex\plugins\cache\personal\system-cli-subagents\local`.
- Чому так: personal plugin discovery для Codex спирається на реальний source root + cache layer; без правильного source path UI може показувати плагін, але tool set у новому thread не підхоплюється.
- Перевірено: файлова наявність cache copy, повторна перевірка thread-у показала, що старий thread ще не бачить tool set mid-flight.
- Ризики: поточний thread не hot-reload-иться; для остаточної перевірки потрібен fresh thread/app reload, але зараз уже виправлено неправильний attach root.

- Задача: Public repo, README trim, SkillOpt loop.
- Знайдено: repo вже був готовий до публікації, але README був занадто довгим і не мав окремого self-improvement path для skill-доків.
- Змінено: repo переведено у public, README скорочено, додано `skillopt/README.md`, `skillopt/best_skill.md`, і `skills/skillopt-self-improvement/SKILL.md` для validation-gated SkillOpt loop.
- Чому так: це дає окремий, явний шлях для майбутніх поліпшень skill-доків без вигаданих можливостей.
- Перевірено: GitHub repo visibility, локальні файли репо, робочий fallback script, і наявність проміжного best-skill artifact.
- Ризики: SkillOpt runner тут ще не інтегрований як автоматичний CI job; поки це documented loop plus promoted artifact.

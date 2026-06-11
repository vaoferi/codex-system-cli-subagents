# SPEC: Freebuff Worker Bridge V1

## Мета
Зробити першу версію Codex plugin/skill/MCP bridge для одного робочого `freebuff2api`-акаунта.

У цій версії Codex не стає native subagent. Він працює як оркестратор: викликає connectable MCP tool, який надсилає задачу до локального `freebuff2api`, отримує структурований результат і, якщо треба, запускає наступний крок сам.

## Контекст
- У системі є `freebuff2api` як OpenAI-compatible HTTP bridge.
- У v1 використовуємо один конкретний upstream account, який уже працює в цьому bridge.
- `openclaude` тимчасово виключено з v1.
- `opencode` у v1 не використовуємо.
- Codex не керує hidden terminal для виконання роботи.
- Codex надсилає задачу до локального `freebuff2api` і отримує результат назад у компактному форматі.
- Автоматичний queue/rotate/multi-account режим у v1 не робимо.
- Якщо `freebuff.exe` запущений, але HTTP listener відсутній, це трактуємо як неповну інсталяцію bridge і спершу робимо `repair-first`, а не self-work.

## Що змінюємо
- Оновлюємо plugin scaffold у workspace-root `.agents/plugins/system-cli-subagents` під `freebuff2api` worker bridge.
- Додаємо connectable MCP surface, який Codex може бачити як tool.
- Оновлюємо skill так, щоб він прямо казав: це MCP tool + HTTP worker, не native subagent і не видимий термінал.
- Оновлюємо launcher script так, щоб він:
  - перевіряв доступність локального `freebuff2api`;
  - обирав модель автоматично з `/v1/models`;
  - надсилав структурований prompt;
  - повертав компактний JSON для Codex.
- Оновлюємо опис і супровідні документи, щоб вони не обіцяли multi-account або quota bypass.
- Залишаємо місце для майбутнього queue або додаткових backends після підтвердженого single-account contract.

## Що не змінюємо
- Не змінюємо Codex core.
- Не робимо `freebuff2api` native subagent.
- Не додаємо `openclaude` у v1.
- Не додаємо `opencode` у v1.
- Не додаємо multi-account rotation.
- Не додаємо bypass квот або лімітів.
- Не додаємо hidden terminal flow.
- Не ламаємо існуючий plugin scaffold.

## Ризики
- Локальний `freebuff2api` може бути не запущений або бути на іншому URL.
- API key може бути увімкнений на сервері, і клієнт має передавати його правильно.
- Набір моделей залежить від реально доступного `/v1/models`, тому auto-select має мати fallback.
- Відповідь моделі може бути невалідним JSON, тому bridge має нормалізувати результат.
- Якщо bridge лише стартує процес, але не відкриває порт, потрібен repair-first цикл до будь-якого висновку про “працює/не працює”.

## План
1. Додати MCP server для `freebuff2api`.
2. Оновити skill під connectable MCP bridge.
3. Переписати launcher script на HTTP bridge до локального API.
4. Оновити spec і output-документи.
5. Запустити validation plugin.
6. Зробити dry-run bridge і local MCP client test.
7. Зафіксувати результат у project log.

## Перевірка
- `python C:\Users\vaoferi\.codex\skills\.system\plugin-creator\scripts\validate_plugin.py C:\Users\vaoferi\Documents\Codex\2026-06-11\new-chat\.agents\plugins\system-cli-subagents`
- `pwsh -NoLogo -NoProfile -File C:\Users\vaoferi\Documents\Codex\2026-06-11\new-chat\.agents\plugins\system-cli-subagents\scripts\invoke-freebuff-worker.ps1 -Task 'Dry run task' -DryRun`
- Local MCP client test that lists `freebuff_delegate`.
- Перевірка, що bridge описує `source = freebuff2api`, а не `mode = visible-terminal`.
- Перевірка, що `openclaude` у v1 не використовується.
- Перевірка, що output/docs не обіцяють multi-account, queue bypass або hidden terminal.
- `pwsh -NoLogo -NoProfile -File C:\Users\vaoferi\Documents\Codex\2026-06-11\new-chat\.agents\plugins\system-cli-subagents\scripts\invoke-freebuff-worker.ps1 -Task 'Inspect the repo and summarize the bridge architecture' -Profile research -BaseUrl http://127.0.0.1:8123 -ApiKey test-key`

## Готово, якщо
- Codex може надіслати задачу до одного локального `freebuff2api` worker-а через MCP tool;
- bridge автоматично обирає модель з доступних;
- Codex отримує короткий структурований результат;
- `openclaude` виключено з v1;
- маніфест і skill валідні;
- зміни задокументовано.

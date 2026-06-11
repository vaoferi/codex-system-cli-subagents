# Codex system-cli-subagents

Це репозиторій із результатом роботи над `system-cli-subagents`.

## Що всередині

- `.agents/plugins/system-cli-subagents` - встановлений Codex plugin
- `outputs/system-cli-subagents.md` - короткий user-facing опис
- `work/SPEC.md` - специфікація задачі
- `work/docs/history/project_log.md` - історія змін і перевірок

## Що вміє

- оффлоадити дослідницькі та чорнові задачі у локальний `freebuff2api`
- вибирати модель автоматично за профілем
- повертати короткий JSON для Codex
- працювати через fallback script, якщо MCP tool не підхопився в поточному thread

## Як використовувати

У Codex пиши так:

```text
[@system-cli-subagents](plugin://system-cli-subagents@personal) <твоя задача>
```

Або запускай fallback script напряму:

```powershell
pwsh -NoLogo -NoProfile -File ".agents/plugins/system-cli-subagents/scripts/invoke-freebuff-worker.ps1" -Profile research -Task "..."
```

## Примітка

У цій збірці прямий MCP tool `freebuff_delegate` є в файлах плагіна, але практичний робочий шлях у Codex зараз іде через fallback script.

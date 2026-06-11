# Codex system-cli-subagents

Repo з результатом роботи над `system-cli-subagents`.

## Що тут

- `.agents/plugins/system-cli-subagents` - сам plugin
- `outputs/system-cli-subagents.md` - короткий опис для використання
- `work/SPEC.md` - специфікація
- `work/docs/history/project_log.md` - історія змін
- `skillopt/` - каркас постійного поліпшення skill-доків через SkillOpt

## Як використовувати зараз

```text
[@system-cli-subagents](plugin://system-cli-subagents@personal) <задача>
```

Fallback без MCP:

```powershell
pwsh -NoLogo -NoProfile -File ".agents/plugins/system-cli-subagents/scripts/invoke-freebuff-worker.ps1" -Profile research -Task "..."
```

## Що важливо

- `freebuff2api` тут працює як worker bridge
- прямий `freebuff_delegate` є в файлах плагіна, але current Codex thread може піти через fallback script
- `SkillOpt` використовується як цикл для покращення `SKILL.md`, а не як model fine-tuning

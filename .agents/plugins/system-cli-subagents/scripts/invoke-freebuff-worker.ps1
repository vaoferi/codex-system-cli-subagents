[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Task,

    [string]$Context = '',

    [ValidateSet('research', 'draft', 'review', 'general')]
    [string]$Profile = 'research',

    [ValidateSet('auto', 'fast', 'balanced', 'deep')]
    [string]$ModelStrategy = 'auto',

    [string]$Model,

    [string]$BaseUrl = $(if ($env:FREEBUFF_API_BASE_URL) { $env:FREEBUFF_API_BASE_URL } else { 'http://127.0.0.1:8000' }),

    [string]$ApiKey = $env:FREEBUFF_API_KEY,

    [int]$TimeoutSeconds = 120,

    [int]$MaxTokens = 1200,

    [switch]$DryRun
)

$target = Join-Path $PSScriptRoot '..\..\..\..\work\plugins\system-cli-subagents\scripts\invoke-freebuff-worker.ps1'
& $target @PSBoundParameters

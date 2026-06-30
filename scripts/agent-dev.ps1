param(
    [string]$Prompt = "Read AGENTS.md, docs/requirements.md, and docs/review.md if it exists. Implement the next required login feature changes. Run relevant tests and summarize verification."
)

$ErrorActionPreference = "Stop"

function Find-CodexOrFail {
    $commandNames = @("codex", "codex.exe")

    foreach ($name in $commandNames) {
        $command = Get-Command $name -ErrorAction SilentlyContinue
        if ($command) {
            return $command.Source
        }
    }

    $windowsAppsMatches = Get-ChildItem `
        -Path "C:\Program Files\WindowsApps\OpenAI.Codex_*\app\resources\codex.exe" `
        -ErrorAction SilentlyContinue |
        Sort-Object FullName -Descending

    if ($windowsAppsMatches) {
        return $windowsAppsMatches[0].FullName
    }

    throw "Codex CLI was not found. Install Codex, enable the Codex app execution alias, or adjust scripts/agent-dev.ps1 to point to codex.exe."
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $repoRoot

New-Item -ItemType Directory -Force docs | Out-Null

$codex = Find-CodexOrFail
& $codex $Prompt

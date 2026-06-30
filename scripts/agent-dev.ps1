param(
    [string]$Prompt = "Read AGENTS.md, docs/requirements.md, and docs/review.md if it exists. Implement the next required login feature changes. Run relevant tests and summarize verification."
)

$ErrorActionPreference = "Stop"

function Find-CommandOrFail {
    param([string]$Name)

    $command = Get-Command $Name -ErrorAction SilentlyContinue
    if (-not $command) {
        throw "Command '$Name' was not found. Install it or adjust this script to use the correct CLI name."
    }

    return $command.Source
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $repoRoot

New-Item -ItemType Directory -Force docs | Out-Null

$codex = Find-CommandOrFail "codex"
& $codex $Prompt


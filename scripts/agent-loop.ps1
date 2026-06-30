param(
    [int]$MaxRounds = 3
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $repoRoot

if (!(Test-Path ".git")) {
    throw "This directory is not a Git repository. Run 'git init' and create an initial commit before starting the agent loop."
}

New-Item -ItemType Directory -Force docs | Out-Null

for ($round = 1; $round -le $MaxRounds; $round++) {
    Write-Host "Agent round $round of $MaxRounds"

    & (Join-Path $PSScriptRoot "agent-dev.ps1")

    if (Test-Path ".\gradlew.bat") {
        .\gradlew.bat test
    }

    if (Test-Path ".\frontend\package.json") {
        npm --prefix frontend install
        npm --prefix frontend test
        npm --prefix frontend run build
    }

    & (Join-Path $PSScriptRoot "agent-review.ps1")

    $review = Get-Content "docs/review.md" -Raw
    if ($review -match "(?m)^\s*APPROVED\s*$") {
        Write-Host "Claude Code approved the change."
        git status --short
        exit 0
    }

    if ($review -notmatch "CHANGES_REQUESTED") {
        throw "docs/review.md does not contain APPROVED or CHANGES_REQUESTED."
    }

    Write-Host "Claude Code requested changes. Codex will address them in the next round if rounds remain."
}

throw "Agent loop reached MaxRounds without approval. See docs/review.md for the latest review."


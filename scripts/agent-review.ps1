param(
    [string]$Prompt = "Read CLAUDE.md. Review the current git diff and write the review to docs/review.md. Do not modify source files."
)

$ErrorActionPreference = "Stop"

function Find-FirstCommandOrFail {
    param([string[]]$Names)

    foreach ($name in $Names) {
        $command = Get-Command $name -ErrorAction SilentlyContinue
        if ($command) {
            return $command.Source
        }
    }

    throw "None of these commands were found: $($Names -join ', '). Install Claude Code or adjust this script to use the correct CLI name."
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $repoRoot

New-Item -ItemType Directory -Force docs | Out-Null

$claude = Find-FirstCommandOrFail @("claude", "claude-code")
& $claude $Prompt

if (!(Test-Path "docs/review.md")) {
    throw "Claude review did not create docs/review.md."
}


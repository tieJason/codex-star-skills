param(
  [string]$Source = (Join-Path $PSScriptRoot "..\skills"),
  [string]$Destination = $(if ($env:CODEX_HOME) { Join-Path $env:CODEX_HOME "skills" } else { Join-Path $HOME ".codex\skills" })
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $Source)) {
  throw "Skills source not found: $Source"
}

New-Item -ItemType Directory -Force -Path $Destination | Out-Null

Get-ChildItem -LiteralPath $Source -Directory | ForEach-Object {
  $target = Join-Path $Destination $_.Name
  if (Test-Path -LiteralPath $target) {
    Remove-Item -LiteralPath $target -Recurse -Force
  }
  Copy-Item -LiteralPath $_.FullName -Destination $target -Recurse
  Write-Host "Installed $($_.Name) -> $target"
}

Write-Host ""
Write-Host "Done. Restart Codex or reload skills if needed."

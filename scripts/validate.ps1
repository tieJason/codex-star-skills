$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$skills = Join-Path $root "skills"
$errors = New-Object System.Collections.Generic.List[string]

if (-not (Test-Path -LiteralPath $skills)) {
  throw "Missing skills directory: $skills"
}

Get-ChildItem -LiteralPath $skills -Directory | Sort-Object Name | ForEach-Object {
  $name = $_.Name
  $skillMd = Join-Path $_.FullName "SKILL.md"
  $openaiYaml = Join-Path $_.FullName "agents\openai.yaml"

  if ($name -notmatch '^[a-z0-9][a-z0-9-]{0,62}[a-z0-9]$') {
    $errors.Add("${name}: invalid skill directory name")
  }

  if (-not (Test-Path -LiteralPath $skillMd)) {
    $errors.Add("${name}: missing SKILL.md")
    return
  }

  $content = Get-Content -Encoding UTF8 -Raw -LiteralPath $skillMd

  if ($content -notmatch '(?s)^---\r?\n.*?\r?\n---') {
    $errors.Add("${name}: missing YAML frontmatter")
  }

  if ($content -notmatch "(?m)^name:\s*`"?$([regex]::Escape($name))`"?\s*$") {
    $errors.Add("${name}: frontmatter name must match directory")
  }

  if ($content -notmatch '(?m)^description:\s*\S') {
    $errors.Add("${name}: description is missing or too short")
  }

  if ($content -match '\[TODO|TODO:|Structuring This Skill') {
    $errors.Add("${name}: template TODO text remains")
  }

  if (-not (Test-Path -LiteralPath $openaiYaml)) {
    $errors.Add("${name}: missing agents/openai.yaml")
  }
}

if ($errors.Count -gt 0) {
  $errors | ForEach-Object { Write-Error $_ }
  exit 1
}

Write-Host "All skills passed repository validation."

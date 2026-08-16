$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$skillRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$skill = Get-Content -LiteralPath (Join-Path $skillRoot 'SKILL.md') -Raw
$config = Get-Content -LiteralPath (Join-Path $skillRoot 'references\configuration-index.md') -Raw
$deprecated = Get-Content -LiteralPath (Join-Path $skillRoot 'references\deprecated\code-generation.md') -Raw
$allMarkdown = (Get-ChildItem -LiteralPath $skillRoot -Recurse -File -Filter '*.md' |
    ForEach-Object { Get-Content -LiteralPath $_.FullName -Raw }) -join "`n"

$failures = [System.Collections.Generic.List[string]]::new()
function Assert-Contains([string]$Text, [string]$Expected, [string]$Scenario) {
    if (-not $Text.Contains($Expected)) {
        $script:failures.Add("$Scenario is missing '$Expected'")
    }
}

$routingScenarios = @(
    @{ Name = 'project creation'; Values = @('create-project.md', 'selected database Pack reference') },
    @{ Name = 'entity development'; Values = @('business-development.md', 'entity-framework-core.md', 'common.md') },
    @{ Name = 'authentication'; Values = @('packs/security/authentication.md', 'packs/security/identity.md', 'configuration-index.md', 'apis/identity.md') },
    @{ Name = 'authorization'; Values = @('workflows/authorization.md', 'function-authorization.md', 'data-authorization.md', 'apis/authorization.md') },
    @{ Name = 'provider migration'; Values = @('workflows/migrations.md', 'migration-pack.md', 'one provider reference') },
    @{ Name = 'Swagger'; Values = @('packs/infrastructure/swagger.md', 'infrastructure/web Pack', 'operations.md') },
    @{ Name = 'Redis'; Values = @('packs/infrastructure/redis.md', 'infrastructure/web Pack', 'operations.md') },
    @{ Name = 'Hangfire'; Values = @('packs/infrastructure/hangfire.md', 'infrastructure/web Pack', 'operations.md') }
)
foreach ($scenario in $routingScenarios) {
    foreach ($value in $scenario.Values) {
        Assert-Contains $skill $value $scenario.Name
    }
}

Assert-Contains $config '"Jwt": { "Enabled": false }' 'disabled-JWT guidance'
Assert-Contains $config '"Cookie"' 'Cookie login guidance'
Assert-Contains $config 'OSharp__Jwt__Secret' 'JWT secret guidance'
Assert-Contains $config 'throws during registration if JWT is enabled and the secret is empty' 'invalid JWT guidance'
Assert-Contains $deprecated 'Do not use `OSharp.CodeGeneration`' 'generator rejection'
Assert-Contains $skill 'Never add a target-project reference to a repository `src/OSharp*` project.' 'local OSharp source rejection'
Assert-Contains $skill 'Reuse `$(OSharpVersion)` for every OSharp package.' 'central OSharp version policy'

if ($allMarkdown -match '(?is)<ProjectReference[^>]+src[\\/]OSharp') {
    $failures.Add('Skill contains a forbidden framework ProjectReference example')
}
if ($allMarkdown -match '(?is)<PackageReference\s+Include="OSharp[^\"]*"\s+Version="\d') {
    $failures.Add('Skill contains a hard-coded OSharp package version example')
}
foreach ($credentialMatch in [regex]::Matches($allMarkdown, '(?i)(Password|ClientSecret|ApiKey|Jwt__Secret)\s*[=:]\s*[^\s`"}]+')) {
    if (-not $credentialMatch.Value.Contains('CHANGE_ME') -and -not $credentialMatch.Value.EndsWith('false')) {
        $failures.Add("Skill may contain a credential-like literal: $($credentialMatch.Value)")
    }
}

if ($failures.Count -gt 0) {
    Write-Host "OSharp Skill scenario tests failed with $($failures.Count) error(s):" -ForegroundColor Red
    $failures | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
    exit 1
}

Write-Host 'OSharp Skill scenario tests passed: creation, entity, Cookie/JWT, authorization, provider migration, Swagger, Redis, Hangfire, NuGet-only, and hand-written-code guidance.' -ForegroundColor Green

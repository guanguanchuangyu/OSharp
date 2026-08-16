param(
    [string]$RepoRoot
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$skillRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
    $RepoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..\..\..'))
} else {
    $RepoRoot = [System.IO.Path]::GetFullPath($RepoRoot)
}

$errors = [System.Collections.Generic.List[string]]::new()
function Add-AuditError([string]$Message) {
    $script:errors.Add($Message)
}

$expectedRevision = '72aa44909d7ffab2d9fde09249b585053668dbeb'
$expectedPackFiles = @(
    'core/osharp-core.md', 'core/dependency.md', 'core/event-bus.md', 'core/aspnet-core.md',
    'web/mvc.md', 'web/mvc-function.md', 'web/endpoints.md', 'web/signalr.md', 'web/health-checks.md',
    'data/entity-framework-core.md', 'data/migration-pack.md', 'data/mysql.md', 'data/sqlserver.md',
    'data/sqlite.md', 'data/postgresql.md', 'data/oracle.md',
    'security/entity-info.md', 'security/identity.md', 'security/authentication.md',
    'security/function-authorization.md', 'security/data-authorization.md',
    'hosting/systems.md', 'hosting/audit.md', 'hosting/infos.md',
    'infrastructure/automapper.md', 'infrastructure/swagger.md', 'infrastructure/mini-profiler.md',
    'infrastructure/redis.md', 'infrastructure/hangfire.md', 'infrastructure/log4net.md',
    'infrastructure/nlog.md', 'infrastructure/exceptionless.md'
)
$requiredHeadings = @(
    '## Purpose',
    '## Official NuGet acquisition',
    '## Pack type and activation',
    '## Effective Pack dependencies',
    '## Registered services',
    '## Lifecycle behavior',
    '## Configuration',
    '## Injectable service APIs',
    '## Related HTTP APIs',
    '## Extension points and project placement',
    '## Common mistakes and verification',
    '## Evidence anchors'
)

$packsRoot = Join-Path $skillRoot 'references\packs'
foreach ($relativePath in $expectedPackFiles) {
    $packPath = Join-Path $packsRoot $relativePath
    if (-not (Test-Path -LiteralPath $packPath -PathType Leaf)) {
        Add-AuditError "Missing Pack reference: $relativePath"
        continue
    }

    $content = Get-Content -LiteralPath $packPath -Raw
    foreach ($heading in $requiredHeadings) {
        if (-not $content.Contains($heading)) {
            Add-AuditError "Missing heading '$heading' in $relativePath"
        }
    }
}

$actualPackFiles = Get-ChildItem -LiteralPath $packsRoot -Recurse -File -Filter '*.md' |
    Where-Object { $_.Name -ne 'index.md' } |
    ForEach-Object { $_.FullName.Substring($packsRoot.Length).TrimStart('\').Replace('\', '/') }
foreach ($unexpected in @($actualPackFiles | Where-Object { $_ -notin $expectedPackFiles })) {
    Add-AuditError "Unindexed Pack reference: $unexpected"
}

$baselinePath = Join-Path $skillRoot 'references\baseline.md'
$baseline = Get-Content -LiteralPath $baselinePath -Raw
foreach ($token in @('net10.0', '10.0.0', $expectedRevision, 'templates/G2Cy.OSharp.Templates', 'samples/web')) {
    if (-not $baseline.Contains($token)) {
        Add-AuditError "Baseline metadata is missing '$token'"
    }
}

$propsPath = Join-Path $RepoRoot 'templates\G2Cy.OSharp.Templates\content\Directory.Build.props'
if (-not (Test-Path -LiteralPath $propsPath -PathType Leaf)) {
    Add-AuditError "Template baseline file is missing: $propsPath"
} else {
    $props = Get-Content -LiteralPath $propsPath -Raw
    if (-not $props.Contains('<TargetFramework>net10.0</TargetFramework>')) {
        Add-AuditError 'Template target framework drifted from net10.0'
    }
    if (-not $props.Contains('<OSharpVersion>10.0.0</OSharpVersion>')) {
        Add-AuditError 'Template OSharpVersion drifted from 10.0.0'
    }
}

try {
    $actualRevision = (& git -C $RepoRoot rev-parse HEAD 2>$null).Trim()
    if ($LASTEXITCODE -ne 0) {
        Add-AuditError 'Unable to read the repository revision with git'
    } elseif ($actualRevision -ne $expectedRevision) {
        Add-AuditError "Repository revision drift: expected $expectedRevision, found $actualRevision"
    }
} catch {
    Add-AuditError "Unable to audit repository revision: $($_.Exception.Message)"
}

$expectedPackTypes = @(
    'OsharpCorePack', 'DependencyPack', 'EventBusPack', 'AspNetCorePack',
    'MvcPack', 'MvcFunctionPack', 'EndpointsPack', 'SignalRPack', 'HealthChecksPack',
    'EntityFrameworkCorePackBase', 'MigrationPackBase', 'MySqlEntityFrameworkCorePack',
    'SqlServerEntityFrameworkCorePack', 'SqliteEntityFrameworkCorePack',
    'NpgsqlEntityFrameworkCorePack', 'OracleEntityFrameworkCorePack',
    'EntityInfoPack', 'IdentityPack', 'AuthenticationPack', 'FunctionAuthorizationPack',
    'DataAuthorizationPack', 'SystemsPack', 'AuditPack', 'InfosPack', 'AutoMapperPack',
    'SwaggerPack', 'MiniProfilerPack', 'RedisPack', 'HangfirePack', 'Log4NetPack',
    'NLogPack', 'ExceptionlessPack'
)
$sourceFiles = Get-ChildItem -LiteralPath (Join-Path $RepoRoot 'src') -Recurse -File -Filter '*.cs'
$sourceText = ($sourceFiles | ForEach-Object { Get-Content -LiteralPath $_.FullName -Raw }) -join "`n"
foreach ($packType in $expectedPackTypes) {
    if ($sourceText -notmatch "\bclass\s+$([regex]::Escape($packType))\b") {
        Add-AuditError "Pack type no longer found in source: $packType"
    }
}

$markdownFiles = Get-ChildItem -LiteralPath $skillRoot -Recurse -File -Filter '*.md'
foreach ($markdownFile in $markdownFiles) {
    $markdown = Get-Content -LiteralPath $markdownFile.FullName -Raw
    $matches = [regex]::Matches($markdown, '\[[^\]]+\]\(([^)]+)\)')
    foreach ($match in $matches) {
        $target = $match.Groups[1].Value.Trim()
        if ($target -match '^(https?:|mailto:|#)') {
            continue
        }
        $target = ($target -split '#', 2)[0]
        $resolved = [System.IO.Path]::GetFullPath((Join-Path $markdownFile.DirectoryName $target))
        if (-not (Test-Path -LiteralPath $resolved)) {
            $relativeMarkdown = $markdownFile.FullName.Substring($skillRoot.Length).TrimStart('\')
            Add-AuditError "Broken link in $relativeMarkdown -> $target"
        }
    }

    if ($markdown -match '(?is)<ProjectReference[^>]+src[\\/]OSharp') {
        Add-AuditError "Forbidden framework ProjectReference example in $($markdownFile.FullName)"
    }
    if ($markdown -match '(?is)<PackageReference\s+Include="OSharp[^\"]*"\s+Version="\d') {
        Add-AuditError "Hard-coded OSharp package version example in $($markdownFile.FullName)"
    }
}

if ($errors.Count -gt 0) {
    Write-Host "OSharp Skill source-drift audit failed with $($errors.Count) error(s):" -ForegroundColor Red
    $errors | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
    exit 1
}

Write-Host "OSharp Skill source-drift audit passed: $($expectedPackFiles.Count) Pack references, required sections, baseline metadata, source types, links, and NuGet boundaries." -ForegroundColor Green

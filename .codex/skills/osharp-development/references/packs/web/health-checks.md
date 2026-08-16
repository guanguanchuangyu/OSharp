# HealthChecksPack

## Purpose
Register health checks for process memory, configured databases, and optional Hangfire, and expose a health endpoint.

## Official NuGet acquisition
Containing package: `OSharpNS.AspNetCore.Diagnostics`. Add it directly to WebApi with `$(OSharpVersion)` when health checks are required.

## Pack type and activation
Namespace/type: `OSharp.AspNetCore.Diagnostics.HealthChecksPack`. Add its package and `.AddPack<HealthChecksPack>()`.

## Effective Pack dependencies
`AspNetCorePack`; Application level, order 1.

## Registered services
ASP.NET Core health-check builder plus memory, EF database/provider, and conditional Hangfire checks derived from configuration.

## Lifecycle behavior
When enabled, maps health middleware at the configured URL (default `/health`).

## Configuration
`OSharp:HealthChecks:Enabled`, `Url`, `PrivateMemory`, `VirtualMemorySize`, and `WorkingSet`; it also observes DbContexts and `OSharp:Hangfire:Enabled`.

## Injectable service APIs
Standard ASP.NET Core health-check services.

## Related HTTP APIs
GET on the configured health URL; response formatting follows the Pack's options.

## Extension points and project placement
Add application-specific checks in WebApi through the standard health-check builder before startup completes.

## Common mistakes and verification
Do not expose sensitive diagnostic detail publicly. Verify unhealthy dependencies produce the expected status and deployment probe behavior.

## Evidence anchors
`src/OSharp.AspNetCore.Diagnostics/HealthChecksPack.cs`; `src/OSharp.AspNetCore.Diagnostics/HealthChecksPackBase.cs`; its project package metadata.

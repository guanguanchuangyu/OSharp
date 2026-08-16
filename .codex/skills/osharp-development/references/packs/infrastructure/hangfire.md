# HangfirePack

## Purpose
Register Hangfire storage/server, expose a protected dashboard, and run an optional application job bootstrapper.

## Official NuGet acquisition
Package: `OSharp.Hangfire`. Add directly to WebApi with `Version="$(OSharpVersion)"` when background jobs are required.

## Pack type and activation
Namespace/type: `OSharp.Hangfire.HangfirePack`. Add `.AddPack<HangfirePack>()` and configure storage.

## Effective Pack dependencies
`AspNetCorePack`; Framework level, order 0.

## Registered services
Hangfire global configuration and server. The application may provide `IHangfireJobRunner` and dashboard authorization behavior.

## Lifecycle behavior
Configures logging, maps the dashboard, and invokes `IHangfireJobRunner` when available.

## Configuration
`OSharp:Hangfire:StorageConnectionString`, `WorkerCount`, `DashboardUrl` (default `/hangfire`), and comma-separated `Roles`. Health checks observe `Enabled` when present.

## Injectable service APIs
Hangfire job clients/recurring jobs and `IHangfireJobRunner`.

## Related HTTP APIs
Dashboard at the configured URL; it is infrastructure UI, not a business controller.

## Extension points and project placement
Place job orchestration/runner in WebApi and business job work behind scoped Core services. Create scopes correctly for jobs.

## Common mistakes and verification
Protect the dashboard, do not hard-code storage credentials, and make jobs retry-safe/idempotent. Run a queued and recurring job in validation.

## Evidence anchors
`src/OSharp.Hangfire/HangfirePack.cs`; `HangfirePackBase.cs`; `IHangfireJobRunner.cs`; sample job runner.

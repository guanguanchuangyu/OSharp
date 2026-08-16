---
name: osharp-development
description: Create and extend layered .NET 10 OSharp applications using the G2Cy template and official OSharp NuGet packages. Use for OSharp project creation, Pack selection and configuration, entities, EF Core mappings and migrations, services, controllers, authentication, authorization, hosting APIs, Swagger, caching, jobs, logging, diagnostics, and troubleshooting. Excludes local framework source references, custom local Packs, and code-generation workflows.
---

# OSharp Development

Build and maintain OSharp applications from the repository's G2Cy template while consuming framework code only through official NuGet packages.

## Core procedure

1. Read [baseline.md](references/baseline.md), [project-architecture.md](references/project-architecture.md), and [coding-conventions.md](references/coding-conventions.md) before changing a target project.
2. Inspect the target solution, selected database provider, existing `PackageReference` entries, `Startup` Pack chain, and `OSharp` configuration.
3. Select only the Pack, API, and workflow references needed for the task from the routing and catalog below.
4. Implement hand-written code in the correct G2Cy layer. Reuse `$(OSharpVersion)` for every OSharp package.
5. Restore and build the affected solution. For configuration or startup failures, use [operations.md](references/workflows/operations.md).

## Non-negotiable rules

- Consume built-in OSharp framework components from official NuGet packages. Never add a target-project reference to a repository `src/OSharp*` project.
- Treat source paths in references as behavioral evidence only.
- Keep the target on `net10.0` and OSharp `10.0.0` unless the user explicitly requests a coordinated baseline upgrade.
- Keep the solution dependency direction `WebApi -> EntityConfiguration -> Core`.
- Do not add `OSharp.CodeGeneration`, generator workflows, or target-project `*.generated.cs` files. Read [code-generation.md](references/deprecated/code-generation.md) when modernizing legacy code.
- Keep locally referenced custom Packs and framework source customization out of scope. Report that boundary instead of inventing a local integration.
- Never commit real connection strings, JWT secrets, OAuth client secrets, mail passwords, Redis credentials, or vendor API keys.
- Preserve existing user changes and follow the repository's normal edit and validation rules.

## Task routing

- Create/install a project: read [create-project.md](references/workflows/create-project.md), then the selected database Pack reference.
- Add entities, mappings, services, or controllers: read [business-development.md](references/workflows/business-development.md), EF Core references, and [common.md](references/apis/common.md).
- Add or run migrations: read [migrations.md](references/workflows/migrations.md), [entity-framework-core.md](references/packs/data/entity-framework-core.md), [migration-pack.md](references/packs/data/migration-pack.md), and one provider reference.
- Implement login, Cookie, JWT, OAuth2, users, or roles: read [authentication.md](references/packs/security/authentication.md), [identity.md](references/packs/security/identity.md), [configuration-index.md](references/configuration-index.md), and [identity API](references/apis/identity.md).
- Implement function or data authorization: read [authorization.md](references/workflows/authorization.md), the function/data authorization Pack references, and [authorization API](references/apis/authorization.md).
- Implement menus, settings, audit, or messaging: read the matching hosting Pack and API appendix.
- Add Swagger, caching, jobs, profiling, logging, diagnostics, or SignalR: read only the matching infrastructure/web Pack and [operations.md](references/workflows/operations.md).

## Pack catalog

Core: [OsharpCorePack](references/packs/core/osharp-core.md), [DependencyPack](references/packs/core/dependency.md), [EventBusPack](references/packs/core/event-bus.md), [AspNetCorePack](references/packs/core/aspnet-core.md).

Web: [MvcPack](references/packs/web/mvc.md), [MvcFunctionPack](references/packs/web/mvc-function.md), [EndpointsPack](references/packs/web/endpoints.md), [SignalRPack](references/packs/web/signalr.md), [HealthChecksPack](references/packs/web/health-checks.md).

Data: [EF Core behavior](references/packs/data/entity-framework-core.md), [MigrationPack](references/packs/data/migration-pack.md), [MySQL](references/packs/data/mysql.md), [SQL Server](references/packs/data/sqlserver.md), [SQLite](references/packs/data/sqlite.md), [PostgreSQL](references/packs/data/postgresql.md), [Oracle](references/packs/data/oracle.md).

Security: [EntityInfoPack](references/packs/security/entity-info.md), [IdentityPack](references/packs/security/identity.md), [AuthenticationPack](references/packs/security/authentication.md), [FunctionAuthorizationPack](references/packs/security/function-authorization.md), [DataAuthorizationPack](references/packs/security/data-authorization.md).

Hosting: [SystemsPack](references/packs/hosting/systems.md), [AuditPack](references/packs/hosting/audit.md), [InfosPack](references/packs/hosting/infos.md).

Infrastructure: [AutoMapperPack](references/packs/infrastructure/automapper.md), [SwaggerPack](references/packs/infrastructure/swagger.md), [MiniProfilerPack](references/packs/infrastructure/mini-profiler.md), [RedisPack](references/packs/infrastructure/redis.md), [HangfirePack](references/packs/infrastructure/hangfire.md), [Log4NetPack](references/packs/infrastructure/log4net.md), [NLogPack](references/packs/infrastructure/nlog.md), [ExceptionlessPack](references/packs/infrastructure/exceptionless.md).

Use [packs/index.md](references/packs/index.md) for package ownership, acquisition mode, and the dependency overview.

## API references

- [Identity and authentication](references/apis/identity.md)
- [Function and data authorization](references/apis/authorization.md)
- [Systems and menus](references/apis/systems.md)
- [Audit](references/apis/audit.md)
- [Infos and messaging](references/apis/infos.md)
- [Common controller and response conventions](references/apis/common.md)

## Validation and maintenance

Run the read-only checks after changing this Skill:

```powershell
powershell -ExecutionPolicy Bypass -File .codex/skills/osharp-development/scripts/audit-source-drift.ps1
powershell -ExecutionPolicy Bypass -File .codex/skills/osharp-development/scripts/test-skill.ps1
```

Read [validation.md](references/validation.md) before updating the baseline or Pack catalog.

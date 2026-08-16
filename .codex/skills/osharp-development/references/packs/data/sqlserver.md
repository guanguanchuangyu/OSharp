# SqlServerEntityFrameworkCorePack

## Purpose
Configure OSharp EF Core, Dapper execution, option driving, and sequential GUID generation for SQL Server.

## Official NuGet acquisition
Package: `OSharp.EntityFrameworkCore.SqlServer`. Add one direct WebApi reference with `Version="$(OSharpVersion)"` when `dbtype=mssql`.

## Pack type and activation
Namespace/type: `OSharp.Entity.SqlServer.SqlServerEntityFrameworkCorePack`. Activated by `SqlServerDefaultDbContextMigrationPack`.

## Effective Pack dependencies
`EntityFrameworkCorePackBase -> EventBusPack`; Framework level, order 1.

## Registered services
SQL Server sequential GUID generator, scoped Dapper executor, singleton options driver, and EF base services.

## Lifecycle behavior
Initializes SQL Server contexts; migration behavior belongs to the application migration Pack.

## Configuration
Use `DatabaseType: SqlServer`; the template uses LocalDB/integrated security for a safe development baseline.

## Injectable service APIs
Repositories, unit of work, EF context, connection provider, and provider SQL executor.

## Related HTTP APIs
None.

## Extension points and project placement
Provider/migration code in WebApi; mappings in EntityConfiguration.

## Common mistakes and verification
Review SQL Server-specific column/index rules and never ship the LocalDB connection as production configuration. Restore, migrate, and build.

## Evidence anchors
`src/OSharp.EntityFrameworkCore.SqlServer`; template `SqlServerDefaultDbContextMigrationPack.cs`.

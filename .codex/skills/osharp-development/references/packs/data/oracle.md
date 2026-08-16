# OracleEntityFrameworkCorePack

## Purpose
Configure OSharp EF Core, Oracle Dapper execution, option driving, and sequential GUID generation for Oracle.

## Official NuGet acquisition
Package: `OSharp.EntityFrameworkCore.Oracle`. Add one direct WebApi reference with `Version="$(OSharpVersion)"` when `dbtype=oracle`.

## Pack type and activation
Namespace/type: `OSharp.Entity.Oracle.OracleEntityFrameworkCorePack`. Activated by `OracleDefaultDbContextMigrationPack`.

## Effective Pack dependencies
`EntityFrameworkCorePackBase -> EventBusPack`; Framework level, order 1.

## Registered services
Oracle sequential GUID generator, scoped Oracle Dapper executor, singleton options driver, and EF base services.

## Lifecycle behavior
Initializes Oracle contexts; the host migration Pack performs context/model/seed initialization.

## Configuration
Use `DatabaseType: Oracle` with an externally supplied Oracle user, password, and data source.

## Injectable service APIs
Standard EF repository/unit-of-work and provider SQL executor APIs.

## Related HTTP APIs
None.

## Extension points and project placement
Keep Oracle provider and migration setup in WebApi and account for Oracle identifier/type rules in mappings/migrations.

## Common mistakes and verification
Do not assume Oracle migrations behave like SQL Server. Restore/build is compile acceptance; validate against an available Oracle service separately.

## Evidence anchors
`src/OSharp.EntityFrameworkCore.Oracle`; template `OracleDefaultDbContextMigrationPack.cs`.

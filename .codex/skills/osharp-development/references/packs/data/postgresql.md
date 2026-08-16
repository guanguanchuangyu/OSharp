# NpgsqlEntityFrameworkCorePack

## Purpose
Configure OSharp EF Core, Npgsql/Dapper execution, option driving, and sequential GUID generation for PostgreSQL.

## Official NuGet acquisition
Package: `OSharp.EntityFrameworkCore.PostgreSql`. Add one direct WebApi reference with `Version="$(OSharpVersion)"` when `dbtype=pgsql`.

## Pack type and activation
Namespace/type: `OSharp.Entity.PostgreSql.NpgsqlEntityFrameworkCorePack`. Activated by `NpgsqlDefaultDbContextMigrationPack`.

## Effective Pack dependencies
`EntityFrameworkCorePackBase -> EventBusPack`; Framework level, order 1.

## Registered services
Npgsql sequential GUID generator, scoped PostgreSQL Dapper executor, singleton options driver, and EF base services.

## Lifecycle behavior
Initializes `DatabaseType.PostgreSql` contexts; migration/seed behavior is in the application Pack.

## Configuration
Use `OSharp:DbContexts:PostgreSql`, matching `DatabaseType: PostgreSql`, with credentials supplied externally.

## Injectable service APIs
Repositories, unit of work, EF context, and provider SQL executor.

## Related HTTP APIs
None.

## Extension points and project placement
Keep Npgsql migration Pack in WebApi and mappings in EntityConfiguration.

## Common mistakes and verification
The CLI choice is `pgsql`, while the OSharp database type/config key is `PostgreSql`. Preserve that distinction and run a real migration test.

## Evidence anchors
`src/OSharp.EntityFrameworkCore.PostgreSql`; template `NpgsqlDefaultDbContextMigrationPack.cs`.

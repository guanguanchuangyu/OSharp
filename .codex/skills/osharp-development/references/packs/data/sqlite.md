# SqliteEntityFrameworkCorePack

## Purpose
Configure OSharp EF Core and provider services for a SQLite database.

## Official NuGet acquisition
Package: `OSharp.EntityFrameworkCore.Sqlite`. Add one direct WebApi reference with `Version="$(OSharpVersion)"` when `dbtype=sqlite`.

## Pack type and activation
Namespace/type: `OSharp.Entity.Sqlite.SqliteEntityFrameworkCorePack`. Activated by `SqliteDefaultDbContextMigrationPack`.

## Effective Pack dependencies
`EntityFrameworkCorePackBase -> EventBusPack`; Framework level, order 1.

## Registered services
SQLite sequential GUID generator, scoped Dapper executor, singleton options driver, and EF base services.

## Lifecycle behavior
Initializes SQLite contexts and model metadata; the migration Pack performs seed/migration lifecycle work.

## Configuration
Use `DatabaseType: Sqlite` and a local `Data Source=app.db` development path.

## Injectable service APIs
Standard EF repository/unit-of-work and provider SQL executor APIs.

## Related HTTP APIs
None.

## Extension points and project placement
Use SQLite for local/single-file scenarios and keep schema mappings portable if another provider is expected later.

## Common mistakes and verification
Account for SQLite type/concurrency/alter-table limitations. Do not commit a runtime database file unintentionally.

## Evidence anchors
`src/OSharp.EntityFrameworkCore.Sqlite`; template `SqliteDefaultDbContextMigrationPack.cs`.

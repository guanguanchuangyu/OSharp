# MySqlEntityFrameworkCorePack

## Purpose
Configure OSharp EF Core, Dapper SQL execution, option driving, and sequential GUID generation for MySQL.

## Official NuGet acquisition
Package: `OSharp.EntityFrameworkCore.MySql`. Add one direct WebApi reference with `Version="$(OSharpVersion)"` when `dbtype=mysql`.

## Pack type and activation
Namespace/type: `OSharp.Entity.MySql.MySqlEntityFrameworkCorePack`. Activation is through `MySqlDefaultDbContextMigrationPack`, not a second direct registration.

## Effective Pack dependencies
`EntityFrameworkCorePackBase -> EventBusPack`; Framework level, order 1.

## Registered services
MySQL sequential GUID generator, scoped MySQL Dapper executor, and singleton MySQL DbContext-options driver plus EF base services.

## Lifecycle behavior
Validates/initializes MySQL DbContexts; the migration Pack handles context and seed initialization.

## Configuration
Use `DatabaseType: MySql` and a MySQL connection string under `OSharp:DbContexts:MySql`.

## Injectable service APIs
Standard repository/unit-of-work APIs and provider-specific `ISqlExecutor<,>`.

## Related HTTP APIs
None.

## Extension points and project placement
Keep provider reference and migration Pack in WebApi; keep mappings provider-neutral where possible.

## Common mistakes and verification
Current OSharp 10 resolves Pomelo 9 against EF Core 10 and emits `NU1608` while compiling successfully. Record rather than suppress it; test runtime database behavior.

## Evidence anchors
`src/OSharp.EntityFrameworkCore.MySql`; template `MySqlDefaultDbContextMigrationPack.cs` and conditional WebApi package reference.

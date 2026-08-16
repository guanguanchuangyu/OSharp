# Database migration workflow

Read [EF Core behavior](../packs/data/entity-framework-core.md), [MigrationPack behavior](../packs/data/migration-pack.md), and exactly one selected provider reference before changing migrations.

## Preconditions

- The generated WebApi project contains one provider `PackageReference` and its one matching `*DefaultDbContextMigrationPack`.
- `DesignTimeDefaultDbContextFactory` and the runtime Pack select the same provider and connection shape.
- Entity mappings compile in the EntityConfiguration layer.
- A safe development connection string is supplied outside committed configuration.

## Create and apply

From the generated solution directory, replace `Company.Product` and the migration name:

```powershell
dotnet ef migrations add AddOrders --project src/Company.Product.WebApi --startup-project src/Company.Product.WebApi
dotnet ef database update --project src/Company.Product.WebApi --startup-project src/Company.Product.WebApi
```

Review the migration before applying it. Prefer explicit migrations; keep distributed `AutoMigrationEnabled` false. For production, create a reviewed deployment artifact/script according to the provider's operational practice rather than running startup auto-migration blindly.

## Provider matrix

| `dbtype` | NuGet package | Runtime migration Pack |
|---|---|---|
| `mysql` | `OSharp.EntityFrameworkCore.MySql` | `MySqlDefaultDbContextMigrationPack` |
| `mssql` | `OSharp.EntityFrameworkCore.SqlServer` | `SqlServerDefaultDbContextMigrationPack` |
| `sqlite` | `OSharp.EntityFrameworkCore.Sqlite` | `SqliteDefaultDbContextMigrationPack` |
| `pgsql` | `OSharp.EntityFrameworkCore.PostgreSql` | `NpgsqlDefaultDbContextMigrationPack` |
| `oracle` | `OSharp.EntityFrameworkCore.Oracle` | `OracleDefaultDbContextMigrationPack` |

Do not add provider projects from this repository. If design-time creation fails, compare the selected provider, design-time factory, Pack, `DatabaseType`, and connection string before changing package versions.


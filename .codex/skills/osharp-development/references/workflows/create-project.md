# Create a G2Cy OSharp project

## Install from the local template package

Build either packaging form without changing template content:

```powershell
dotnet pack templates/G2Cy.OSharp.Templates/G2Cy.OSharp.Templates.csproj -c Release
dotnet new install templates/G2Cy.OSharp.Templates/bin/Release/G2Cy.OSharp.Templates.1.0.0.nupkg
```

The retained `g2cytemplate.nuspec` can also be packed with a NuGet CLI when that packaging workflow is required. Install the resulting `.nupkg`; do not install `docs/old-template`.

## Generate

```powershell
dotnet new g2cy-api -n Company.Product --dbtype mysql
```

Supported `dbtype` values are `mysql` (default), `mssql`, `sqlite`, `pgsql`, and `oracle`. The generated solution remains `WebApi -> EntityConfiguration -> Core`; the database choice keeps exactly one provider package and one matching migration Pack.

## Validate immediately

1. Confirm `Directory.Build.props` targets `net10.0` and defines `OSharpVersion` once.
2. Confirm all OSharp references use `Version="$(OSharpVersion)"` and no generated project references a repository `src/OSharp*` project.
3. Confirm `Startups` contains only the selected provider migration Pack.
4. Put a development connection string in user secrets or a local ignored override.
5. Run `dotnet restore` and `dotnet build` from the generated solution directory.

MySQL currently may report the baseline compatibility warning documented in [baseline.md](../baseline.md). Record the warning; do not silently switch framework or provider versions in a generated project.

## Provider routing

- `mysql`: [MySQL Pack](../packs/data/mysql.md)
- `mssql`: [SQL Server Pack](../packs/data/sqlserver.md)
- `sqlite`: [SQLite Pack](../packs/data/sqlite.md)
- `pgsql`: [PostgreSQL Pack](../packs/data/postgresql.md)
- `oracle`: [Oracle Pack](../packs/data/oracle.md)


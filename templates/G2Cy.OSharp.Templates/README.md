# G2Cy OSharp Templates

This package provides the `g2cy-api` solution template. It creates a layered OSharp Web API solution with `Core`, `EntityConfiguration`, and `WebApi` projects.

## Pack and install locally

```powershell
dotnet pack .\G2Cy.OSharp.Templates.csproj -c Release
dotnet new install .\bin\Release\G2Cy.OSharp.Templates.1.0.0.nupkg
```

Alternatively, use the standalone NuSpec with the NuGet CLI:

```powershell
nuget pack .\g2cytemplate.nuspec -OutputDirectory .\artifacts
dotnet new install .\artifacts\G2Cy.OSharp.Templates.1.0.0.nupkg
```

## Create a solution

MySQL is the default database provider:

```powershell
dotnet new g2cy-api -n Company.Product
```

Select a provider explicitly with `--dbtype`:

```powershell
dotnet new g2cy-api -n Company.Product --dbtype mysql
dotnet new g2cy-api -n Company.Product --dbtype mssql
dotnet new g2cy-api -n Company.Product --dbtype sqlite
dotnet new g2cy-api -n Company.Product --dbtype pgsql
dotnet new g2cy-api -n Company.Product --dbtype oracle
```

All generated projects target .NET 10. The generated connection string is for local development only. Replace its placeholder values before starting the application. The OSharp dependency version is maintained once in the generated `Directory.Build.props` file.

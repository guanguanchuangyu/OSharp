# MigrationPackBase application behavior

## Purpose
Connect `DefaultDbContext` to a selected provider, initialize model metadata, optionally migrate, and execute ordered seed-data initializers.

## Official NuGet acquisition
Base package: `OSharp.EntityFrameworkCore`; provider behavior comes from exactly one official provider package using `$(OSharpVersion)`.

## Pack type and activation
Base type: `MigrationPackBase<DefaultDbContext>`. The G2Cy template supplies one concrete hand-written host Pack per `dbtype` and retains only the selected file.

## Effective Pack dependencies
Each concrete migration Pack declares one provider Pack; the provider inherits `EventBusPack` through EF Core base behavior.

## Registered services
Adds the selected `DefaultDbContext` and provider options. The host also registers entity batch configurations for comments and UTC date conversion.

## Lifecycle behavior
During `UseOSharp()`, resolves the configured context, initializes the model cache/entity manager, honors `AutoMigrationEnabled`, and runs ordered `ISeedDataInitializer` services.

## Configuration
Requires the selected `OSharp:DbContexts:<provider>` entry with matching `DatabaseType` and `DbContextTypeName`.

## Injectable service APIs
`DefaultDbContext`, `IUnitOfWork`, repositories, entity manager, model cache, and seed initializer contracts.

## Related HTTP APIs
None.

## Extension points and project placement
Keep the concrete migration Pack and design-time context factory in WebApi. Put mappings in EntityConfiguration and seed initializers in Core.

## Common mistakes and verification
Do not retain multiple provider migration Packs or enable automatic production migration casually. Use the workflow in [migrations.md](../../workflows/migrations.md).

## Evidence anchors
`src/OSharp.EntityFrameworkCore/MigrationPackBase.cs`; `templates/G2Cy.OSharp.Templates/content/src/G2Cy.WebApi/Startups`.

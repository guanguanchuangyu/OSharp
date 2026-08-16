# EntityFrameworkCorePackBase behavior

## Purpose
Provide repositories, unit of work, DbContext option discovery, entity metadata, audit integration, key generation, SQL execution abstractions, model caching, and read/write split policy used by all database providers.

## Official NuGet acquisition
Containing package: `OSharp.EntityFrameworkCore`. Reference it directly from EntityConfiguration with `$(OSharpVersion)`; the selected provider also depends on it.

## Pack type and activation
Abstract type: `OSharp.Entity.EntityFrameworkCorePackBase`. Do not register the base; register one selected provider through the template migration Pack.

## Effective Pack dependencies
`EventBusPack`; Framework level. Provider Packs use order 1.

## Registered services
Scoped `IRepository<,>`, `IUnitOfWork`, `IAuditEntityProvider`, `IConnectionStringProvider`, and SQL/provider services; singleton entity manager/model cache/key generators/batch configurations; master/slave selectors.

## Lifecycle behavior
Validates configured DbContexts for its provider and initializes entity metadata/model behavior during `UseOSharp()`.

## Configuration
Consumes `OSharp:DbContexts`; see [configuration-index.md](../../configuration-index.md). Exactly one active configuration should point to a given context type.

## Injectable service APIs
`IRepository<TEntity,TKey>`, `IUnitOfWork`, `IEntityManager`, `IConnectionStringProvider`, `ISqlExecutor<,>`, and EF `DbContext` services.

## Related HTTP APIs
None directly; application services/controllers expose data.

## Extension points and project placement
Put entities/contracts in Core, mappings in EntityConfiguration, and selected provider/migration host code in WebApi.

## Common mistakes and verification
Do not mix multiple provider packages into one generated variant. Keep queries server-side, review transaction boundaries, and build/run migrations for the selected provider.

## Evidence anchors
`src/OSharp.EntityFrameworkCore/EntityFrameworkCorePackBase.cs`; `src/OSharp.EntityFrameworkCore`; template EntityConfiguration project.

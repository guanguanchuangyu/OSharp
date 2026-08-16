# Project architecture

## Layer dependency

```text
G2Cy.WebApi
    -> G2Cy.EntityConfiguration
        -> G2Cy.Core
```

Do not reverse this direction and do not introduce a framework-source project into it.

## G2Cy.Core

Place business entities, DTOs, service contracts, service implementations, business Packs already supplied by official packages, authorization attributes, seed-data initializers, and domain events here.

Typical official dependencies are `OSharp.Authorization.Datas`, `OSharp.Authorization.Functions`, and `OSharp.AutoMapper`, all using `$(OSharpVersion)`.

## G2Cy.EntityConfiguration

Place hand-written `EntityTypeConfigurationBase<TEntity, TKey>` mappings here. Reference `G2Cy.Core` and the official `OSharp.EntityFrameworkCore` package. Keep database-provider selection out of this layer unless mapping behavior is genuinely provider-specific.

## G2Cy.WebApi

Place `Program`, `Startup`, Pack registration, application controllers, migration Packs, design-time context factory, host configuration, logging configuration, and `appsettings*.json` here. Reference `G2Cy.EntityConfiguration`, `OSharp.Hosting.Apis`, and only the selected database provider package.

## Startup lifecycle

`services.AddOSharp()` automatically adds `OsharpCorePack`, `DependencyPack`, and `EventBusPack`. Each `.AddPack<T>()` recursively includes `DependsOnPacks` dependencies and sorts them by `PackLevel` and `Order`. `app.UseOSharp()` invokes each Pack's runtime initialization; ASP.NET Packs receive the `WebApplication`.

Do not call Pack service or pipeline methods manually unless a Pack reference explicitly documents an application extension point.

## Package placement

- Put business compile-time packages in Core.
- Put EF mapping infrastructure in EntityConfiguration.
- Put hosting, provider, Swagger, profiling, logging, diagnostics, caching, and background-job packages in WebApi.
- Avoid duplicate direct references when an umbrella package already supplies a type transitively.

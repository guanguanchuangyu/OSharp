# Hand-written coding conventions

## General rules

- Use file-scoped namespaces and one primary public type per file.
- Match namespaces to the G2Cy layer and feature folder.
- Use constructor injection for application services; use scoped lifetimes for services that access repositories or a unit of work.
- Expose asynchronous database and identity operations as `Task` methods and propagate cancellation when the underlying API accepts it.
- Validate public inputs and return OSharp `OperationResult`/`AjaxResult` shapes consistently with surrounding code.
- Preserve user code and avoid broad mechanical rewrites.

## Entities and mappings

- Put entities under `G2Cy.Core/<Feature>/Entities` and use the OSharp entity base/interface matching the chosen key type.
- Put DTOs near the feature contract; do not expose EF tracking entities directly as mutable HTTP inputs.
- Put mappings under `G2Cy.EntityConfiguration/<Feature>` and derive from `EntityTypeConfigurationBase<TEntity, TKey>`.
- Configure table, key, length, requiredness, indexes, relationships, delete behavior, comments, and concurrency explicitly when the domain requires them.
- Register mapping assemblies through the existing OSharp entity discovery path; do not add ad-hoc context model code when a configuration class suffices.

## Services and transactions

- Define a focused contract in Core and a hand-written implementation in the same feature.
- Query through `IRepository<TEntity, TKey>`/`IUnitOfWork`; keep `IQueryable` composition server-side.
- Use `[UnitOfWork]` on HTTP actions or explicit unit-of-work APIs where the current pattern requires a transaction.
- Keep authorization checks at the service or controller boundary that owns the operation.

## Controllers

- Put application controllers in `G2Cy.WebApi`, deriving from the appropriate OSharp/API base used by the target.
- OSharp hosting APIs use conventional `{area}/{controller}/{action}` routing; do not invent a route without inspecting existing endpoint configuration.
- Apply `ModuleInfo`, `DependOnFunction`, `ApiAuthorize`, `LoggedIn`, `RoleLimit`, and `UnitOfWork` deliberately.
- Keep controllers thin: validate transport input, call a contract, and shape the response.

## Generated-code prohibition

Write contracts, services, configurations, DTOs, and controllers by hand. Do not introduce `OSharp.CodeGeneration`, Razor generator templates, or target-project files ending in `.generated.cs`.

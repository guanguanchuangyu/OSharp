# Hand-written business development

Use this workflow for a new aggregate or API. Inspect a nearby target-project feature first and preserve its naming, base types, and result conventions.

## 1. Core layer

1. Add the entity and domain rules under the feature namespace in `*.Core`.
2. Add input/output DTOs with validation attributes where the HTTP boundary needs them.
3. Add an application contract that exposes query composition and named operations returning `OperationResult`/`OperationResult<T>` as appropriate.
4. Add the hand-written service implementation. Inject framework contracts/repositories; do not embed HTTP concerns in it.

Keep authorization abstractions and AutoMapper profiles in Core when they are part of the application contract. Never create `*.generated.cs` companions.

## 2. EntityConfiguration layer

Add the EF Core mapping for the entity: table/schema, keys, lengths, precision, required values, indexes, relationships, and delete behavior. Keep provider-neutral mapping here unless a real provider difference requires a guarded provider-specific configuration.

The layer references `OSharp.EntityFrameworkCore` through NuGet and references only the application Core project. Verify the mapping is discoverable by the application's entity-configuration convention before creating a migration.

## 3. WebApi layer

Add a controller deriving from the appropriate site/admin base. Inject the application contract, translate `OperationResult` to `AjaxResult`, and use the existing conventional route style. Add:

- `[ModuleInfo]` to actions that must participate in function discovery;
- `[UnitOfWork]` to state-changing transaction boundaries;
- `[DependOnFunction(nameof(Read))]` when a mutation should inherit read permission;
- `[LoggedIn]` or the admin base where authentication is required.

Use [common API conventions](../apis/common.md). Do not expose `IQueryable` directly over HTTP; apply the framework paging/filter pipeline and return a page/result envelope.

## 4. Finish

Create/review the provider migration, restore, build, and exercise one allowed and one rejected request. For authorization-sensitive entities, also follow [authorization.md](authorization.md).


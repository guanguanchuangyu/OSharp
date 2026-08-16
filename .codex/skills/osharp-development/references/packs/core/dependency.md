# DependencyPack

## Purpose
Discover OSharp dependency markers and register application services with their declared lifetimes, plus lazy and scoped-resolution helpers.

## Official NuGet acquisition
Containing package: `OSharp.Core`. Acquisition: transitive; use the shared OSharp version only if a standalone project directly references the core package.

## Pack type and activation
Namespace/type: `OSharp.Dependency.DependencyPack`. Loaded automatically by `AddOSharp()`.

## Effective Pack dependencies
None. Core level, order 1, after `OsharpCorePack`.

## Registered services
Registers `Lazy<>`, `IHybridServiceScopeFactory`, `ScopedDictionary`, and discovered dependency types based on OSharp dependency attributes/interfaces.

## Lifecycle behavior
Service discovery occurs during registration; runtime behavior is the base enable step.

## Configuration
None.

## Injectable service APIs
Use normal constructor injection. `IScopedServiceResolver`/scope helpers are infrastructure escape hatches, not a replacement for explicit dependencies.

## Related HTTP APIs
None.

## Extension points and project placement
Mark hand-written application services with the supported dependency lifetime convention when existing code uses it; otherwise register explicitly in the owning layer.

## Common mistakes and verification
Avoid duplicate registrations and service-location-heavy designs. Confirm lifetime matches repository/unit-of-work usage.

## Evidence anchors
`src/OSharp/Dependency/DependencyPack.cs`; `src/OSharp/Dependency`.

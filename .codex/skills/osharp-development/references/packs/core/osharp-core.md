# OsharpCorePack

## Purpose
Provide OSharp options, default cache/filter/key-value services, cancellation, email, startup logging, and HTTP crypto foundations. `AddOSharp()` always loads it.

## Official NuGet acquisition
Containing package: `OSharp.Core`. Acquisition: transitive through selected OSharp packages; do not add a redundant reference in the G2Cy template. Use `$(OSharpVersion)` if a standalone library needs it.

## Pack type and activation
Namespace/type: `OSharp.Core.Packs.OsharpCorePack`. Activation is automatic through `services.AddOSharp()`; do not add it manually.

## Effective Pack dependencies
None. It is a Core-level root Pack.

## Registered services
Singletons include `IConfigureOptions<OsharpOptions>`, cancellation provider, default email sender, startup logger, `ICacheService`, and key-value support; `IFilterService` is scoped; client crypto and handler are transient; distributed memory cache is added.

## Lifecycle behavior
`AddServices` supplies core services. Runtime `UsePack` only marks the Pack enabled.

## Configuration
Binds the `OSharp` root through `OsharpOptionsSetup`; use [configuration-index.md](../../configuration-index.md).

## Injectable service APIs
Primary services: `ICacheService`, `IFilterService`, `IKeyValueStore`, `IEmailSender`, `ICancellationTokenProvider`, and client HTTP crypto.

## Related HTTP APIs
None directly.

## Extension points and project placement
Replace default services through normal DI in the application layer only when required; do not copy the Pack source.

## Common mistakes and verification
Do not register a second options root or assume optional external providers are enabled. Verify `AddOSharp()` executes once and build the solution.

## Evidence anchors
`src/OSharp/Core/Packs/OSharpCorePack.cs`; `src/OSharp/Core/Options/OsharpOptionsSetup.cs`; `src/OSharp/Extensions/ServiceExtensions.cs`.

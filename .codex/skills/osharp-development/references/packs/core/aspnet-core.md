# AspNetCorePack

## Purpose
Bridge OSharp core services to ASP.NET Core by providing HTTP context, current principal, and host-side HTTP crypto.

## Official NuGet acquisition
Containing package: `OSharp.AspNetCore`. Recommended acquisition: transitive through `OSharp.Hosting.Apis` in WebApi.

## Pack type and activation
Namespace/type: `OSharp.AspNetCore.AspNetCorePack`. It is added transitively by web Packs such as MVC, endpoints, authentication, Swagger, and diagnostics.

## Effective Pack dependencies
None; Core level, order 2. `AddOSharp()` core Packs remain active separately.

## Registered services
Adds `IHttpContextAccessor`, transient `IHostHttpCrypto`, and transient `IPrincipal` resolved from the current HTTP context.

## Lifecycle behavior
No middleware by itself; dependent ASP.NET Packs provide runtime behavior.

## Configuration
`OSharp:HttpEncrypt` is consumed by host crypto when enabled.

## Injectable service APIs
`IHttpContextAccessor`, `IPrincipal`, and `IHostHttpCrypto`.

## Related HTTP APIs
None directly.

## Extension points and project placement
Use in WebApi only. Prefer controller/user abstractions over direct context access in Core services.

## Common mistakes and verification
Do not access HTTP-scoped state from singleton business services. Verify current-principal behavior inside an actual request.

## Evidence anchors
`src/OSharp.AspNetCore/AspNetCorePack.cs`; `src/OSharp.AspNetCore`.

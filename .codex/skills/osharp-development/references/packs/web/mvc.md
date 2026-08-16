# MvcPack

## Purpose
Configure controllers, views, JSON conventions, routing casing, HTTPS redirection, CORS, request-scoped unit-of-work support, verification codes, and HTTP-aware scope helpers.

## Official NuGet acquisition
Containing package: `OSharp.AspNetCore`. Recommended acquisition: transitive through `OSharp.Hosting.Apis`.

## Pack type and activation
Namespace/type: `OSharp.AspNetCore.Mvc.MvcPack`. Usually included through `MvcFunctionPack`; add it directly only when MVC is needed without function discovery.

## Effective Pack dependencies
`AspNetCorePack`. Application level, order 0.

## Registered services
Adds MVC/controllers, Newtonsoft JSON settings, routing, HTTPS redirection, CORS initializer, scoped unit-of-work implementation, `UnitOfWorkAttribute`, `IVerifyCodeService`, and HTTP-aware cancellation/scope services.

## Lifecycle behavior
Applies configured CORS during `UseOSharp()`.

## Configuration
Consumes `OSharp:Mvc` and `OSharp:Cors`; see [configuration-index.md](../../configuration-index.md).

## Injectable service APIs
`IVerifyCodeService`, `IScopedServiceResolver`, request cancellation, and MVC services.

## Related HTTP APIs
Enables controller execution but declares no hosting actions itself. See [common API](../../apis/common.md).

## Extension points and project placement
Put controllers and transport DTOs in WebApi. Configure JSON/routing/CORS centrally rather than per controller.

## Common mistakes and verification
Avoid permissive production CORS and duplicate MVC registration with conflicting JSON settings. Exercise model binding and authorization in integration tests.

## Evidence anchors
`src/OSharp.AspNetCore/Mvc/MvcPack.cs`; `src/OSharp.AspNetCore/Mvc/MvcPackBase.cs`.

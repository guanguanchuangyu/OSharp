# MvcFunctionPack

## Purpose
Discover MVC controller actions as OSharp functions/modules for function authorization.

## Official NuGet acquisition
Containing package: `OSharp.AspNetCore`. Recommended acquisition: transitive through `OSharp.Hosting.Apis`.

## Pack type and activation
Namespace/type: `OSharp.AspNetCore.Mvc.MvcFunctionPack`. It is normally pulled by `FunctionAuthorizationPack`.

## Effective Pack dependencies
`MvcPack -> AspNetCorePack`; Application level.

## Registered services
Singleton `IFunctionHandler` (`MvcFunctionHandler`) and `IModuleInfoPicker` (`MvcModuleInfoPicker`).

## Lifecycle behavior
Initializes function metadata during `UseOSharp()` so authorization Packs can synchronize and authorize actions.

## Configuration
None directly; function shape comes from controllers and their OSharp attributes.

## Injectable service APIs
`IFunctionHandler` and `IModuleInfoPicker`.

## Related HTTP APIs
Provides metadata for attributed controller actions. See [authorization API](../../apis/authorization.md).

## Extension points and project placement
Apply `ModuleInfo`, `DependOnFunction`, and descriptions to hand-written WebApi actions; keep codes stable once assigned to roles.

## Common mistakes and verification
Missing or changed metadata can invalidate stored function assignments. Inspect discovered modules after controller changes.

## Evidence anchors
`src/OSharp.AspNetCore/Mvc/MvcFunctionPack.cs`; `src/OSharp.AspNetCore/Mvc`.

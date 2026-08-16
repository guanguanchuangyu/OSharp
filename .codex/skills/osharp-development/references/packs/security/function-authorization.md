# FunctionAuthorizationPack

## Purpose
Discover controller functions/modules, persist assignments, cache permissions, and authorize requests for roles/users.

## Official NuGet acquisition
Concrete Pack: `OSharp.Hosting.Core`, supplied transitively by `OSharp.Hosting.Apis`. Keep the template's direct Core reference to `OSharp.Authorization.Functions` for business authorization types; use `$(OSharpVersion)`.

## Pack type and activation
Namespace/type: `OSharp.Hosting.Authorization.FunctionAuthorizationPack`. The G2Cy template registers it explicitly.

## Effective Pack dependencies
Concrete dependencies: `IdentityPack`, `MvcFunctionPack`; base dependencies also include `EventBusPack`. MvcFunction leads to Mvc/AspNetCore.

## Registered services
Singleton authorization handler/cache/module handler; scoped function authorization manager and function/module/assignment stores; transient cache-refresh handlers; module seed initializer.

## Lifecycle behavior
Initializes function metadata, applies Cookie policy, and activates function authorization during `UseOSharp()`.

## Configuration
No dedicated options section. Behavior derives from controller metadata, identity, persisted modules/functions/assignments, and Cookie policy.

## Injectable service APIs
`IFunctionAuthorization`, `IFunctionAuthCache`, `IModuleHandler`, and function/module store contracts.

## Related HTTP APIs
Auth `CheckUrlAuth`/`GetAuthInfo` and Admin Function/Module/RoleFunction/UserFunction endpoints; see [authorization API](../../apis/authorization.md).

## Extension points and project placement
Annotate hand-written WebApi actions; manage application seed/module behavior in Core without copying framework managers.

## Common mistakes and verification
Changing action/module codes can invalidate assignments. Synchronize discovered functions and test authorized/denied users after controller changes.

## Evidence anchors
`src/OSharp.Hosting.Core/Authorization/FunctionAuthorizationPack.cs`; `src/OSharp.Authorization.Functions/FunctionAuthorizationPackBase.cs`; hosting Auth controllers.

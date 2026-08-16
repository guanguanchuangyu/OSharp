# DataAuthorizationPack

## Purpose
Apply entity/row-level authorization through entity metadata, role filters, caches, stores, and query filtering services.

## Official NuGet acquisition
Concrete Pack: `OSharp.Hosting.Core`, supplied through `OSharp.Hosting.Apis`. Keep the direct Core package `OSharp.Authorization.Datas` with `$(OSharpVersion)`.

## Pack type and activation
Namespace/type: `OSharp.Hosting.Authorization.DataAuthorizationPack`. Registered explicitly by the G2Cy template.

## Effective Pack dependencies
`EventBusPack` and `EntityInfoPack`; Application level, order 2.

## Registered services
Singleton `IDataAuthCache`; scoped `IDataAuthService`, data authorization manager, entity-info store and entity-role store; transient cache refresh handler; hosting mapping tuple.

## Lifecycle behavior
Registration enables filters/stores; cache refresh follows data-authorization events. No dedicated middleware call.

## Configuration
No dedicated JSON section. Rules are persisted as entity metadata, role/entity assignments, and `FilterGroup` expressions.

## Injectable service APIs
`IDataAuthService`, `IDataAuthCache`, `IEntityInfoStore`, and `IEntityRoleStore`.

## Related HTTP APIs
Admin EntityInfo and RoleEntity actions are documented in [authorization API](../../apis/authorization.md).

## Extension points and project placement
Apply data authorization to Core queries/services and manage rules through the hosting API. Keep filters server-translatable.

## Common mistakes and verification
Bypassing the authorized query path leaks rows. Test role/user combinations, empty filters, and invalid entity properties.

## Evidence anchors
`src/OSharp.Hosting.Core/Authorization/DataAuthorizationPack.cs`; `src/OSharp.Authorization.Datas/DataAuthorizationPackBase.cs`; hosting EntityInfo/RoleEntity controllers.

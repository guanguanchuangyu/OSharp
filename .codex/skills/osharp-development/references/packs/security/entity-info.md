# EntityInfoPack

## Purpose
Discover and cache entity metadata used by data authorization and the administrative entity-information APIs.

## Official NuGet acquisition
Containing package: `OSharp.Core`. Recommended acquisition: transitive through `OSharp.Authorization.Datas`; keep that direct Core reference from the template.

## Pack type and activation
Namespace/type: `OSharp.Authorization.EntityInfos.EntityInfoPack`. It is pulled automatically by `DataAuthorizationPack`.

## Effective Pack dependencies
None declared; Application level. `DataAuthorizationPack` also depends on `EventBusPack`.

## Registered services
Singleton `IEntityInfoHandler` implemented by `EntityInfoHandler`.

## Lifecycle behavior
Entity information is available for synchronization, filtering, and authorization after Pack initialization.

## Configuration
No dedicated options section. It derives metadata from registered entities and stored hosting entity information.

## Injectable service APIs
`IEntityInfoHandler`; data-authorization stores provide persistence operations.

## Related HTTP APIs
Administrative EntityInfo actions are documented in [authorization API](../../apis/authorization.md).

## Extension points and project placement
Define entities/mappings in Core and EntityConfiguration. Use attributes/metadata supported by current OSharp discovery.

## Common mistakes and verification
Missing entity registration produces incomplete authorization metadata. Verify entity discovery after adding a module.

## Evidence anchors
`src/OSharp/Authorization/EntityInfos/EntityInfoPack.cs`; `src/OSharp.Authorization.Datas`; hosting EntityInfo controller.

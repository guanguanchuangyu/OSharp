# SystemsPack

## Purpose
Provide built-in system/menu business services and mappings used by hosting administration APIs.

## Official NuGet acquisition
Containing package: `OSharp.Hosting.Core`; recommended acquisition is transitive through direct WebApi package `OSharp.Hosting.Apis`.

## Pack type and activation
Namespace/type: `OSharp.Hosting.Systems.SystemsPack`. Registered explicitly by the G2Cy template.

## Effective Pack dependencies
None declared; Application level. Its persistence still requires the selected EF/migration setup.

## Registered services
Scoped `ISystemsContract -> SystemsService` and singleton AutoMapper `IMapTuple`.

## Lifecycle behavior
No middleware. Business behavior is invoked by services/controllers.

## Configuration
No dedicated options section. Settings values are persisted through hosting entities/services.

## Injectable service APIs
`ISystemsContract` exposes menu query, existence, create, update, and delete operations.

## Related HTTP APIs
Admin Menu, Settings, and Pack controllers; see [systems API](../../apis/systems.md).

## Extension points and project placement
Use Core application services for business settings/menu policy and hand-written WebApi endpoints for application-specific operations.

## Common mistakes and verification
Do not conflate configuration secrets with persisted system settings. Test tree/order behavior and permission attributes.

## Evidence anchors
`src/OSharp.Hosting.Core/Systems/SystemsPack.cs`; `ISystemsContract.cs`; hosting Systems controllers.

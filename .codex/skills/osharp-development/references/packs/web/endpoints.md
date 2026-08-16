# EndpointsPack

## Purpose
Map MVC area/default controller routes and provide extension points for SignalR or other endpoints at the end of Pack startup.

## Official NuGet acquisition
Containing package: `OSharp.AspNetCore`. Recommended acquisition: transitive through `OSharp.Hosting.Apis`.

## Pack type and activation
Namespace/type: `OSharp.AspNetCore.Routing.EndpointsPack`. The G2Cy template registers it explicitly.

## Effective Pack dependencies
`AspNetCorePack`; Application level, order 99 so endpoint mapping runs late.

## Registered services
None in the concrete Pack.

## Lifecycle behavior
Calls `MapControllersWithAreaRoute()`, producing `{area:exists}/{controller}/{action}/{id?}` and `{controller}/{action}/{id?}` conventions. The default SignalR override maps no hubs.

## Configuration
None directly.

## Injectable service APIs
None.

## Related HTTP APIs
Makes hosting and application controllers reachable. API appendices use this route convention.

## Extension points and project placement
Map application hubs or custom endpoints in a hand-written application routing Pack/host extension without copying framework source.

## Common mistakes and verification
Do not document REST-style paths that the conventional routes do not produce. List endpoints or run integration requests after route changes.

## Evidence anchors
`src/OSharp.AspNetCore/Routing/EndpointsPack.cs`; `src/OSharp.AspNetCore/Routing/EndpointsPackBase.cs`; `src/OSharp.AspNetCore/ApplicationBuilderExtensions.cs`.

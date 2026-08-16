# SignalRPack

## Purpose
Register OSharp SignalR services, current-user connection tracking, and JSON protocol behavior.

## Official NuGet acquisition
Containing package: `OSharp.AspNetCore`. Add that official package directly only when `OSharp.Hosting.Apis` is absent; otherwise use the transitive dependency.

## Pack type and activation
Namespace/type: `OSharp.AspNetCore.SignalR.SignalRPack`. Register `.AddPack<SignalRPack>()` when the application uses hubs.

## Effective Pack dependencies
`AspNetCorePack`; Application level, order 0.

## Registered services
Singleton `IUserIdProvider`, singleton `IConnectionUserCache`, and SignalR/Newtonsoft protocol services.

## Lifecycle behavior
The Pack registers services. Hub route mapping must be added through endpoint routing; the default `EndpointsPack` maps no hubs.

## Configuration
Uses `OSharp:Mvc:IsLowercaseJsonProperty` for JSON naming behavior. Hub options can be supplied only through a custom integration, which is outside the initial local-Pack scope.

## Injectable service APIs
`IConnectionUserCache`, `IUserIdProvider`, and SignalR hub services.

## Related HTTP APIs
No default hub endpoint. The application defines hub contracts and mapped paths.

## Extension points and project placement
Put hubs in WebApi and map them in application endpoint configuration. Put reusable message contracts in Core when they are transport-neutral.

## Common mistakes and verification
Registering the Pack without mapping a hub exposes nothing. Verify authentication/user-id mapping and reconnect behavior.

## Evidence anchors
`src/OSharp.AspNetCore/SignalR/SignalRPack.cs`; `src/OSharp.AspNetCore/SignalR/SignalRPackBase.cs`; `src/OSharp.AspNetCore/Routing/EndpointsPack.cs`.

# InfosPack

## Purpose
Provide built-in message, receive, and reply business services plus message-created event handling.

## Official NuGet acquisition
Containing package: `OSharp.Hosting.Core`; recommended acquisition is transitive through `OSharp.Hosting.Apis`.

## Pack type and activation
Namespace/type: `OSharp.Hosting.Infos.InfosPack`. Registered explicitly by the G2Cy template.

## Effective Pack dependencies
None declared; application data behavior still depends on EF/migration infrastructure.

## Registered services
Scoped `IInfosContract -> InfosService` and transient `MessageCreatedEventHandler`.

## Lifecycle behavior
Message creation events coordinate receive/message behavior; no middleware.

## Configuration
No dedicated options section.

## Injectable service APIs
`IInfosContract` exposes message/message-receive/message-reply query and CRUD operations from the published hosting contract.

## Related HTTP APIs
Admin Message, MessageReceive, and MessageReply actions; see [infos API](../../apis/infos.md).

## Extension points and project placement
For application messaging, create hand-written Core contracts/services and WebApi controllers. Existing framework generated artifacts are API evidence only.

## Common mistakes and verification
Do not revive the generator workflow when extending messages. Verify recipient creation, read/reply state, transactions, and authorization.

## Evidence anchors
`src/OSharp.Hosting.Core/Infos/InfosPack.cs`; published Infos contract/service files; hosting Infos controllers.

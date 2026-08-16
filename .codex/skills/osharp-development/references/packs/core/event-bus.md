# EventBusPack

## Purpose
Provide the OSharp event bus, event store, and handler dispatch foundation used by EF, identity, authorization, audit, and hosting Packs.

## Official NuGet acquisition
Containing package: `OSharp.Core`. Acquisition: transitive and automatic in `AddOSharp()`.

## Pack type and activation
Namespace/type: `OSharp.EventBuses.EventBusPack`. Do not repeat `.AddPack<EventBusPack>()` in a normal G2Cy host.

## Effective Pack dependencies
None. Core level, order 2.

## Registered services
Singleton `IEventBusBuilder`, in-memory `IEventStore`, and pass-through `IEventBus`. Application event handlers are normally transient through `AddEventHandler<T>()`.

## Lifecycle behavior
Registration establishes dispatch infrastructure; dependent Packs add concrete handlers.

## Configuration
None for the default in-memory/pass-through implementation.

## Injectable service APIs
`IEventBus`, `IEventStore`, `IEventBusBuilder`, and event handler contracts.

## Related HTTP APIs
None directly.

## Extension points and project placement
Place business events and handlers in Core. Register handlers through the existing event extension and keep handlers idempotent where retries are possible.

## Common mistakes and verification
Do not assume a durable external broker: the baseline store/bus is in-process. Verify handler lifetime and transaction ordering.

## Evidence anchors
`src/OSharp/EventBuses/EventBusPack.cs`; `src/OSharp/EventBuses`.

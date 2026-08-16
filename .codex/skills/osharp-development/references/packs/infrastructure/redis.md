# RedisPack

## Purpose
Replace distributed-memory caching with StackExchange.Redis-backed distributed cache and expose OSharp Redis client helpers.

## Official NuGet acquisition
Package: `OSharp.Redis`. Add directly to WebApi with `Version="$(OSharpVersion)"` only when Redis is selected.

## Pack type and activation
Namespace/type: `OSharp.Redis.RedisPack`. Add `.AddPack<RedisPack>()` after supplying configuration.

## Effective Pack dependencies
None declared; Framework level. Core cache abstractions remain available.

## Registered services
Removes/replaces `IDistributedCache` with StackExchange Redis cache and registers Redis client/connection helpers from the package.

## Lifecycle behavior
No middleware; cache behavior begins when services resolve the distributed cache/client.

## Configuration
Requires `OSharp:Redis:Configuration`; optional `InstanceName` defaults to `RedisName`. Supply credentials externally.

## Injectable service APIs
`IDistributedCache`, OSharp `IRedisClient`/Redis client abstractions, and existing `ICacheService` consumers.

## Related HTTP APIs
None.

## Extension points and project placement
Use in WebApi infrastructure. Keep cache keys namespaced and serialize stable DTOs rather than EF tracked entities.

## Common mistakes and verification
Missing configuration fails startup. Test connectivity, expiration, instance prefix, serialization, and outage fallback; never log the connection string.

## Evidence anchors
`src/OSharp.Redis/RedisPack.cs`; `RedisPackBase.cs`; `RedisClient.cs`; `RedisConnectionHelper.cs`.

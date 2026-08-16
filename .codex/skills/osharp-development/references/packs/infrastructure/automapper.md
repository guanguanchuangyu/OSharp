# AutoMapperPack

## Purpose
Collect OSharp `IMapTuple` mappings and construct the application AutoMapper configuration/provider.

## Official NuGet acquisition
Package: `OSharp.AutoMapper`. The G2Cy template references it where mapping types and Pack activation are required; use `$(OSharpVersion)`.

## Pack type and activation
Namespace/type: `OSharp.AutoMapper.AutoMapperPack`. Registered explicitly in template Startup.

## Effective Pack dependencies
None declared; Framework level.

## Registered services
Singleton `MapperConfigurationExpression`, default mapping tuple, and mapping services initialized from all ordered `IMapTuple` registrations.

## Lifecycle behavior
During `UseOSharp()`, aggregates mapping tuples, validates/builds mapping configuration, and makes the mapper available.

## Configuration
No JSON section.

## Injectable service APIs
AutoMapper `IMapper` and OSharp `IMapTuple` mapping extensions.

## Related HTTP APIs
None.

## Extension points and project placement
Add hand-written `IMapTuple` registrations in the owning Core/hosting feature. Keep transport mappings explicit where security-sensitive fields exist.

## Common mistakes and verification
Duplicate/conflicting maps fail startup or map incorrectly. Validate configuration and unit-test important projections.

## Evidence anchors
`src/OSharp.AutoMapper/AutoMapperPack.cs`; hosting `AutoMapperConfiguration` classes; template package references.

# ExceptionlessPack

## Purpose
Register Exceptionless logging and middleware for remote exception/telemetry collection.

## Official NuGet acquisition
Package: `OSharp.Exceptionless`. Add directly to WebApi with `Version="$(OSharpVersion)"` only when selected.

## Pack type and activation
Namespace/type: `OSharp.Exceptionless.ExceptionlessPack`. Add `.AddPack<ExceptionlessPack>()` after configuring the external service.

## Effective Pack dependencies
`AspNetCorePack`; Application level.

## Registered services
When enabled, singleton `ILoggerProvider -> ExceptionlessLoggerProvider` and Exceptionless services.

## Lifecycle behavior
When enabled, configures API key/server URL and calls `UseExceptionless()`.

## Configuration
`OSharp:Exceptionless:Enabled`, `ApiKey`, and optional `ServerUrl`. Provide the API key externally.

## Injectable service APIs
Standard logging and Exceptionless client APIs.

## Related HTTP APIs
None in the application; events are sent to the configured Exceptionless server.

## Extension points and project placement
Configure filters/enrichment in WebApi without attaching sensitive request data.

## Common mistakes and verification
Never commit the API key. Verify disabled mode sends nothing and enabled mode reaches the intended environment/project.

## Evidence anchors
`src/OSharp.Exceptionless/ExceptionlessPack.cs`; `ExceptionlessPackCore.cs`; logger/provider files.

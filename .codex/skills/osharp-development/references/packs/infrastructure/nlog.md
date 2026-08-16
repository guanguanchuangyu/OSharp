# NLogPack

## Purpose
Connect Microsoft.Extensions.Logging to the OSharp NLog provider as an alternative to Log4Net.

## Official NuGet acquisition
Package: `OSharp.NLog`. Add directly to WebApi with `Version="$(OSharpVersion)"` only when selecting NLog.

## Pack type and activation
Namespace/type: `OSharp.NLog.NLogPack`. Replace Log4Net registration/package rather than stacking providers accidentally.

## Effective Pack dependencies
None declared; Core level, order 1.

## Registered services
Singleton `ILoggerProvider -> NLogLoggerProvider`.

## Lifecycle behavior
No middleware.

## Configuration
Uses `nlog.config` from the package/application configuration.

## Injectable service APIs
Standard `ILogger<T>`/`ILoggerFactory`.

## Related HTTP APIs
None.

## Extension points and project placement
Keep NLog targets/rules in WebApi; inject logging abstractions elsewhere.

## Common mistakes and verification
Avoid duplicate provider output and credentials in targets. Verify configuration loading in Release.

## Evidence anchors
`src/OSharp.NLog/NLogPack.cs`; provider/logger files; `nlog.config`.

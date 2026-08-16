# Log4NetPack

## Purpose
Connect Microsoft.Extensions.Logging to the OSharp Log4Net provider.

## Official NuGet acquisition
Package: `OSharp.Log4Net`. Add/reference directly in WebApi with `Version="$(OSharpVersion)"`; the template includes it.

## Pack type and activation
Namespace/type: `OSharp.Log4Net.Log4NetPack`. Register `.AddPack<Log4NetPack>()`.

## Effective Pack dependencies
None declared; Application level, order 0.

## Registered services
Singleton `ILoggerProvider -> Log4NetLoggerProvider`.

## Lifecycle behavior
No middleware; logging provider participates after DI registration.

## Configuration
Uses `log4net.config`, copied to output by the WebApi project.

## Injectable service APIs
Standard `ILogger<T>`/`ILoggerFactory`.

## Related HTTP APIs
None.

## Extension points and project placement
Keep logging config in WebApi and inject `ILogger<T>` into services. Use structured context without secrets.

## Common mistakes and verification
Do not register Log4Net and NLog unintentionally. Verify config copy/output paths and one startup/request log.

## Evidence anchors
`src/OSharp.Log4Net/Log4NetPack.cs`; provider/logger files; template `log4net.config` and csproj content rule.

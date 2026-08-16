# MiniProfilerPack

## Purpose
Register MiniProfiler with EF Core integration and add profiling middleware.

## Official NuGet acquisition
Package: `OSharp.MiniProfiler`. Add/reference it directly in WebApi with `Version="$(OSharpVersion)"`; included by the G2Cy template.

## Pack type and activation
Namespace/type: `OSharp.MiniProfiler.MiniProfilerPack`. Register `.AddPack<MiniProfilerPack>()`.

## Effective Pack dependencies
`AspNetCorePack`; Application level, order 0.

## Registered services
MiniProfiler and EF Core profiling services.

## Lifecycle behavior
Calls `UseMiniProfiler()` during `UseOSharp()`.

## Configuration
The concrete Pack has no required `OSharp` section. `OSharp:Swagger:MiniProfiler` controls Swagger UI integration, not Pack registration.

## Injectable service APIs
Standard MiniProfiler APIs for custom timing steps.

## Related HTTP APIs
MiniProfiler resources/endpoints supplied by the library; no OSharp business controller.

## Extension points and project placement
Use custom timing sparingly in WebApi/Core services and avoid sensitive command text in shared diagnostics.

## Common mistakes and verification
Do not expose profiler data in production unintentionally. Verify EF timings in a development request.

## Evidence anchors
`src/OSharp.MiniProfiler/MiniProfilerPack.cs`; `MiniProfilerPackBase.cs`; template Startup.

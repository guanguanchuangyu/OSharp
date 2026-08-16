# SwaggerPack

## Purpose
Register API exploration/OpenAPI generation and expose Swagger JSON/UI using OSharp endpoint configuration.

## Official NuGet acquisition
Package: `OSharp.Swagger`. Add/reference it directly in WebApi with `Version="$(OSharpVersion)"`; the G2Cy template includes it.

## Pack type and activation
Namespace/type: `OSharp.Swagger.SwaggerPack`. Register `.AddPack<SwaggerPack>()`.

## Effective Pack dependencies
`AspNetCorePack`; Application level, order 2.

## Registered services
MVC API explorer and Swashbuckle generators, including OSharp filters/schema behavior.

## Lifecycle behavior
When enabled, calls Swagger middleware and UI setup during `UseOSharp()`.

## Configuration
`OSharp:Swagger:Enabled`, `Endpoints[]` (`Title`, `Version`, `Url`), `RoutePrefix`, `IsHideSchemas`, and `MiniProfiler`.

## Injectable service APIs
Standard Swagger generator services; application code normally uses attributes/XML comments rather than resolving them.

## Related HTTP APIs
Swagger JSON URLs from `Endpoints` and UI at `RoutePrefix` (default `swagger`).

## Extension points and project placement
Put API annotations and XML-doc behavior in WebApi. Add filters only through application service configuration when required.

## Common mistakes and verification
An enabled configuration needs at least one endpoint. Avoid exposing internal schemas or Swagger UI publicly without policy. Load every configured JSON URL.

## Evidence anchors
`src/OSharp.Swagger/SwaggerPack.cs`; `SwaggerPackBase.cs`; template `appsettings.Development.json`.

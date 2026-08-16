# Build, configuration, and troubleshooting

## Standard checks

1. Inspect `Directory.Build.props`, affected project references, the startup Pack chain, and selected provider.
2. Run `dotnet restore` and `dotnet build` at solution scope.
3. Start with a development environment and verify Pack startup logs, route discovery, health/Swagger endpoints, and one representative business request.
4. Run migrations explicitly when the model changed.

## Configuration safety

Use [configuration-index.md](../configuration-index.md). Commit disabled/safe defaults; supply database passwords, JWT secrets, OAuth secrets, SMTP passwords, Redis credentials, Hangfire storage credentials, and Exceptionless keys externally. Keep Swagger, profiling, dashboards, and diagnostic detail restricted outside development.

## Failure routing

| Symptom | Read/check |
|---|---|
| Pack missing or wrong startup order | [Pack index](../packs/index.md), concrete Pack's dependencies and lifecycle |
| Controller/action not discovered | [MvcFunctionPack](../packs/web/mvc-function.md), [EndpointsPack](../packs/web/endpoints.md), module attributes |
| Login succeeds but request is unauthorized | [AuthenticationPack](../packs/security/authentication.md), scheme selection, [FunctionAuthorizationPack](../packs/security/function-authorization.md) |
| JWT registration/startup failure | `OSharp:Jwt:Enabled`, external secret, issuer/audience, [identity API](../apis/identity.md) |
| Rows are missing or overexposed | [DataAuthorizationPack](../packs/security/data-authorization.md), entity metadata, role filter, principal grants |
| Migration/design-time failure | [migration workflow](migrations.md), one provider Pack, factory/config alignment |
| Swagger missing | [SwaggerPack](../packs/infrastructure/swagger.md), `Enabled`, endpoint/route prefix, environment restriction |
| Redis failure | [RedisPack](../packs/infrastructure/redis.md), external connection settings, network/TLS reachability |
| Job server/dashboard failure | [HangfirePack](../packs/infrastructure/hangfire.md), storage, worker count, dashboard URL/roles |
| Logging/telemetry failure | selected [Log4Net](../packs/infrastructure/log4net.md), [NLog](../packs/infrastructure/nlog.md), or [Exceptionless](../packs/infrastructure/exceptionless.md) reference; use only one intended pipeline |

Do not resolve a failure by adding local references to framework source or copying framework projects into the application. If behavior and docs diverge, run the source-drift audit and update the Skill against the current repository baseline.


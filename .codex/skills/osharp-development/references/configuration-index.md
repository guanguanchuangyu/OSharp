# Configuration index

All framework settings below live under the `OSharp` root unless stated otherwise. Put safe defaults in committed JSON and supply secrets with user secrets, environment variables, or a secret manager.

| Path | Main consumer | Key properties |
|---|---|---|
| `OSharp:DbContexts:<name>` | EF Core/provider/migration Packs | `DbContextTypeName`, `ConnectionString`, `DatabaseType`, `Slaves`, `LazyLoadingProxiesEnabled`, `AuditEntityEnabled`, `AutoMigrationEnabled` |
| `OSharp:OAuth2:<provider>` | AuthenticationPack | `Enabled`, `ClientId`, `ClientSecret` |
| `OSharp:MailSender` | IdentityPack mail sender | `Host`, `Port`, `EnableSsl`, `DisplayName`, `UserName`, `Password` |
| `OSharp:Jwt` | AuthenticationPack | `Enabled`, `Secret`, `Issuer`, `Audience`, `AccessExpireMins`, `RefreshExpireMins`, `IsRefreshAbsoluteExpired` |
| `OSharp:Cookie` | AuthenticationPack | `Enabled`, `CookieName`, paths, `ReturnUrlParameter`, `ExpireMins`, `SlidingExpiration` |
| `OSharp:Mvc` | MvcPack/SignalRPack | `IsLowercaseJsonProperty`, `IsLowercaseUrls` |
| `OSharp:Cors` | MvcPack | policy name, allowed headers/methods/origins/credentials, `Enabled` |
| `OSharp:Redis` | RedisPack | `Configuration`, `InstanceName` |
| `OSharp:Swagger` | SwaggerPack | `Endpoints`, `RoutePrefix`, `IsHideSchemas`, `MiniProfiler`, `Enabled` |
| `OSharp:HttpEncrypt` | core web crypto | `HostPrivateKey`, `HostPublicKey`, `Enabled` |
| `OSharp:HealthChecks` | HealthChecksPack | `Enabled`, `Url`, memory limits |
| `OSharp:Hangfire` | HangfirePack | `StorageConnectionString`, `WorkerCount`, `DashboardUrl`, `Roles` |
| `OSharp:Exceptionless` | ExceptionlessPack | `Enabled`, `ApiKey`, `ServerUrl` |

Logging Packs use `log4net.config` or `nlog.config`; MiniProfiler and AutoMapper have no required `OSharp` section in their concrete Packs.

## Safe authentication baseline

```json
{
  "OSharp": {
    "OAuth2": {},
    "Jwt": { "Enabled": false },
    "Cookie": {
      "Enabled": true,
      "CookieName": "G2Cy.Auth",
      "ExpireMins": 120,
      "SlidingExpiration": true
    }
  }
}
```

When enabling JWT, provide `OSharp__Jwt__Secret` externally. The source throws during registration if JWT is enabled and the secret is empty. The current OAuth2 switch implements Microsoft; do not claim an arbitrary options key is supported.

## Safe provider baselines

- MySQL: local host, database such as `app_dev`, and `Password=CHANGE_ME` only as a replace-before-use placeholder.
- SQL Server: LocalDB with integrated security for local development.
- SQLite: `Data Source=app.db`.
- PostgreSQL: local host with `Password=CHANGE_ME` only as a placeholder.
- Oracle: local service with both user and password placeholders.

Keep `AutoMigrationEnabled` false in the distributed baseline. Run explicit migrations after reviewing schema changes.

## Redis, jobs, and external telemetry

Do not enable Redis, Hangfire, Exceptionless, OAuth2, JWT, or mail until all required external values are supplied. Never place usable credentials in a template, example, test fixture, or Skill output.

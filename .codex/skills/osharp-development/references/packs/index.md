# Built-in Pack index

“Containing package” identifies the official NuGet assembly that defines the Pack. “Recommended acquisition” describes a G2Cy target project; transitive entries do not need a redundant direct reference while the umbrella dependency remains in place.

| Group | Pack/reference | Containing package | Recommended acquisition |
|---|---|---|---|
| Core | OsharpCorePack | `OSharp.Core` | Transitive through any selected OSharp package |
| Core | DependencyPack | `OSharp.Core` | Transitive |
| Core | EventBusPack | `OSharp.Core` | Transitive |
| Core | AspNetCorePack | `OSharp.AspNetCore` | Transitive through `OSharp.Hosting.Apis` |
| Web | MvcPack | `OSharp.AspNetCore` | Transitive through `OSharp.Hosting.Apis` |
| Web | MvcFunctionPack | `OSharp.AspNetCore` | Transitive through `OSharp.Hosting.Apis` |
| Web | EndpointsPack | `OSharp.AspNetCore` | Transitive through `OSharp.Hosting.Apis` |
| Web | SignalRPack | `OSharp.AspNetCore` | Add `OSharp.AspNetCore` directly only if Hosting.Apis is absent |
| Web | HealthChecksPack | `OSharpNS.AspNetCore.Diagnostics` | Direct optional WebApi reference |
| Data | EF Core base | `OSharp.EntityFrameworkCore` | Direct EntityConfiguration reference |
| Data | MigrationPackBase | `OSharp.EntityFrameworkCore` | Direct/transitive with selected provider |
| Data | MySqlEntityFrameworkCorePack | `OSharp.EntityFrameworkCore.MySql` | Direct WebApi provider reference |
| Data | SqlServerEntityFrameworkCorePack | `OSharp.EntityFrameworkCore.SqlServer` | Direct WebApi provider reference |
| Data | SqliteEntityFrameworkCorePack | `OSharp.EntityFrameworkCore.Sqlite` | Direct WebApi provider reference |
| Data | NpgsqlEntityFrameworkCorePack | `OSharp.EntityFrameworkCore.PostgreSql` | Direct WebApi provider reference |
| Data | OracleEntityFrameworkCorePack | `OSharp.EntityFrameworkCore.Oracle` | Direct WebApi provider reference |
| Security | EntityInfoPack | `OSharp.Core` | Transitive through data authorization packages |
| Security | IdentityPack | `OSharp.Hosting.Core` | Transitive through `OSharp.Hosting.Apis` |
| Security | AuthenticationPack | `OSharp.Hosting.Core` | Transitive through `OSharp.Hosting.Apis` |
| Security | FunctionAuthorizationPack | `OSharp.Hosting.Core` | Hosting.Apis plus Core's `OSharp.Authorization.Functions` |
| Security | DataAuthorizationPack | `OSharp.Hosting.Core` | Hosting.Apis plus Core's `OSharp.Authorization.Datas` |
| Hosting | SystemsPack | `OSharp.Hosting.Core` | Transitive through `OSharp.Hosting.Apis` |
| Hosting | AuditPack | `OSharp.Hosting.Core` | Transitive through `OSharp.Hosting.Apis` |
| Hosting | InfosPack | `OSharp.Hosting.Core` | Transitive through `OSharp.Hosting.Apis` |
| Infrastructure | AutoMapperPack | `OSharp.AutoMapper` | Direct in Core/WebApi as required by template |
| Infrastructure | SwaggerPack | `OSharp.Swagger` | Direct optional/default WebApi reference |
| Infrastructure | MiniProfilerPack | `OSharp.MiniProfiler` | Direct optional/default WebApi reference |
| Infrastructure | RedisPack | `OSharp.Redis` | Direct optional WebApi reference |
| Infrastructure | HangfirePack | `OSharp.Hangfire` | Direct optional WebApi reference |
| Infrastructure | Log4NetPack | `OSharp.Log4Net` | Direct default WebApi reference |
| Infrastructure | NLogPack | `OSharp.NLog` | Direct alternative WebApi reference |
| Infrastructure | ExceptionlessPack | `OSharp.Exceptionless` | Direct optional WebApi reference |

## Effective dependency spine

```text
AddOSharp
├─ OsharpCorePack
├─ DependencyPack
└─ EventBusPack

Web Packs -> AspNetCorePack
IdentityPack -> EventBusPack
AuthenticationPack -> IdentityPack + AspNetCorePack
FunctionAuthorizationPack -> IdentityPack + MvcFunctionPack + EventBusPack
DataAuthorizationPack -> EntityInfoPack + EventBusPack
Provider Packs -> EntityFrameworkCorePackBase -> EventBusPack
AuditPack -> EventBusPack
```

Dependencies inherited from abstract Pack bases are effective even when the concrete file has no `DependsOnPacks` attribute.

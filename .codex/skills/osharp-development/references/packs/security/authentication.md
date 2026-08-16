# AuthenticationPack

## Purpose
Configure ASP.NET Core Cookie, JWT bearer, and supported OAuth2 authentication for the built-in hosting identity model, and add authentication middleware to OSharp startup.

Use it for built-in account login, token creation/refresh, current-user behavior, or external login. It does not replace Identity persistence or function/data authorization.

## Official NuGet acquisition
- Containing package: `OSharp.Hosting.Core`.
- Recommended consumer package: direct WebApi reference to `OSharp.Hosting.Apis`, which supplies Hosting.Core transitively.
- Version: `$(OSharpVersion)`.
- Target layer: WebApi.

```xml
<PackageReference Include="OSharp.Hosting.Apis" Version="$(OSharpVersion)" />
```

Never point the target at the repository Hosting.Core project.

## Pack type and activation
Namespace/type: `OSharp.Hosting.Identity.AuthenticationPack`; generic base: `AuthenticationPackBase<User,int>`.

```csharp
using OSharp.Hosting.Identity;

services.AddOSharp()
    .AddPack<AuthenticationPack>();
```

The G2Cy template already registers it.

## Effective Pack dependencies
```text
AuthenticationPack
├─ IdentityPack -> EventBusPack
└─ AspNetCorePack
```

The concrete Pack declares Identity; its generic base declares ASP.NET Core. `AddOSharp()` also loads its three core Packs.

## Registered services
| Service | Implementation/lifetime | Condition |
|---|---|---|
| `IUserClaimsProvider` | `UserClaimsProvider<User,int>`, scoped | Always |
| `IJwtBearerService` | `JwtBearerService<User,int>`, scoped | JWT enabled |
| `OsharpCookieAuthenticationEvents` | scoped | Cookie enabled |
| `Logout_RemoveRefreshTokenEventHandler` | transient | Always |
| `IIdentityContract` | `IdentityService`, scoped | From Identity dependency |

Identity managers, stores, seed data, captcha, and mail belong to [IdentityPack](identity.md).

## Lifecycle behavior
`UseOSharp()` invokes `app.UseAuthentication()`. `EndpointsPack` maps controllers; function/data authorization Packs apply authorization behavior.

## Configuration
Safe Cookie-first baseline:

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

JWT paths include `Enabled`, `Secret`, issuer/audience and access/refresh expiry. Cookie paths include name, login/logout/denied paths, return parameter and expiration. OAuth2 children contain `Enabled`, `ClientId`, and `ClientSecret`.

If JWT is enabled while Cookie is disabled, JWT is the default scheme. An enabled JWT requires an externally supplied non-empty secret. The current provider switch implements Microsoft OAuth2; do not present arbitrary provider keys as supported.

## Injectable service APIs
`IJwtBearerService.CreateToken(...)` and `RefreshToken(...)` are available only with JWT enabled. `IIdentityContract` supplies registration, login, OAuth2 binding, logout, users/roles/relations, and logs. See [identity API](../../apis/identity.md).

## Related HTTP APIs
`OSharp.Hosting.Apis` supplies conventional `/Identity/{action}` endpoints including availability checks, Register, Token, Login, Logout, Profile, email confirmation, password change, and reset flows. The Pack declares no controller itself. See the action/DTO/attribute table in [identity API](../../apis/identity.md).

## Extension points and project placement
Put Pack registration and auth configuration in WebApi. Put business identity policy in Core and HTTP customization in hand-written application controllers. Local custom authentication Packs are outside this Skill.

## Common mistakes and verification
- Enabling JWT without a secret fails registration.
- Calling token APIs while JWT is disabled leaves `IJwtBearerService` unavailable.
- Omitting `UseOSharp()` prevents middleware initialization.
- Treating Cookie and JWT defaults as interchangeable selects the wrong scheme.

Restore/build, then test the selected login and refresh/logout flows without logging secrets.

## Evidence anchors
`templates/G2Cy.OSharp.Templates/content/src/G2Cy.WebApi/Startup.cs`; `src/OSharp.Hosting.Core/Identity/AuthenticationPack.cs`; `src/OSharp.Identity/Authentication/AuthenticationPackBase.cs`; `src/OSharp/Identity/JwtBearer/IJwtBearerService.cs`; `src/OSharp.Hosting.Apis/Controllers/IdentityController.cs`.

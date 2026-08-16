# IdentityPack

## Purpose
Configure the built-in OSharp ASP.NET Core Identity model, stores, managers, online users, identity business contract, seed data, captcha, mail sender, and login events.

## Official NuGet acquisition
Concrete Pack package: `OSharp.Hosting.Core`. Recommended acquisition: transitive through the direct WebApi package `OSharp.Hosting.Apis`; do not add a local source reference. The generic base comes from `OSharp.Identity` transitively.

## Pack type and activation
Namespace/type: `OSharp.Hosting.Identity.IdentityPack`, based on `IdentityPackBase<UserStore, RoleStore, User, int, ...>`. `AuthenticationPack` pulls it automatically; add it directly only for identity without authentication.

## Effective Pack dependencies
`EventBusPack`; Application level, order 0.

## Registered services
Scoped user/role stores, Identity managers, `IOnlineUserProvider`, `IIdentityContract -> IdentityService`; singleton mapping tuple and role seed initializer; captcha services; transient login/logout/online-user event handlers; replaces `IEmailSender` with singleton `MailKitSender`.

## Lifecycle behavior
Registers IdentityCore and stores. Runtime behavior is driven by managers, events, authentication, and seed initialization through the database migration Pack.

## Configuration
Identity options use framework defaults/base customization. Related sections are `OSharp:MailSender`, authentication sections, and captcha library configuration; see [configuration-index.md](../../configuration-index.md).

## Injectable service APIs
`IIdentityContract`, `UserManager<User>`, `RoleManager<Role>`, `SignInManager<User>`, `IOnlineUserProvider`, stores, and `IEmailSender`. Full operations are in [identity API](../../apis/identity.md).

## Related HTTP APIs
`IdentityController`, administrative User/Role/UserRole/LoginLog controllers, and captcha endpoints. See [identity API](../../apis/identity.md).

## Extension points and project placement
Put business identity rules and application services in Core; put transport customization in hand-written WebApi controllers. Do not edit/copy hosting Pack source.

## Common mistakes and verification
Identity persistence requires the selected EF migration Pack and hosting mappings. Configure mail before email flows, and never expose password/token fields in output DTOs.

## Evidence anchors
`src/OSharp.Hosting.Core/Identity/IdentityPack.cs`; `src/OSharp.Identity/Identity/IdentityPackBase.cs`; `src/OSharp.Hosting.Core/Identity/IIdentityContract.cs`; hosting identity controllers.

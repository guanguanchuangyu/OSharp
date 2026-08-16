# Identity and authentication APIs

Read this with the [IdentityPack](../packs/security/identity.md), [AuthenticationPack](../packs/security/authentication.md), and [configuration index](../configuration-index.md).

## Injectable contracts

`IIdentityContract` exposes `Users`, `Roles`, `UserRoles`, `UserLogins`, and `LoginLogs` queryables; user-role and log mutations; `Register`, `Login`, OAuth2 login/bind, one-key login, and `Logout`. Inject it into application services or controllers rather than querying stores directly.

`IJwtBearerService` provides `CreateToken(userId, userName, clientType)` and `RefreshToken(refreshToken)`. It is usable only when JWT is enabled and configured. If `OSharp:Jwt:Enabled` is false, guide clients to Cookie login and do not resolve/call token functionality as if JWT existed.

## Public identity actions

Base route: `/Identity/<Action>`.

| Method | Action | Input | Important behavior/attributes |
|---|---|---|---|
| GET | `CheckUserNameExists` | query `userName` | Availability check. |
| GET | `CheckEmailExists` | query `email` | Availability check. |
| GET | `CheckNickNameExists` | query `nickName` | Availability check. |
| POST | `Register` | `RegisterDto` | `[UnitOfWork]`, `[ModuleInfo]`; depends on the three checks. |
| POST | `Token` | `TokenDto` | `[ModuleInfo]`; JWT must be enabled and secret supplied externally. |
| POST | `Login` | `LoginDto` | `[ModuleInfo]`; uses the enabled authentication scheme. |
| POST | `Logout` | none | `[ModuleInfo]`, `[UnitOfWork]`. |
| GET | `Profile` | none | `[ModuleInfo]`; returns current identity profile. |
| POST | `ConfirmEmail` | `ConfirmEmailDto` | `[ModuleInfo]`, `[UnitOfWork]`. |
| POST | `SendConfirmMail` | `SendMailDto` | `[ModuleInfo]`; depends on email check and mail configuration. |
| POST | `ChangePassword` | `ChangePasswordDto` | `[LoggedIn]`, `[ModuleInfo]`, `[UnitOfWork]`. |
| POST | `SendResetPasswordMail` | `SendMailDto` | `[ModuleInfo]`; depends on email check and mail configuration. |
| POST | `ResetPassword` | `ResetPasswordDto` | `[ModuleInfo]`, `[UnitOfWork]`. |

## Admin identity actions

All routes use `/Admin/<Controller>/<Action>` and the `AdminApiControllerBase` authorization boundary.

| Controller | Actions and inputs |
|---|---|
| `User` | `Read(PageRequest)`, `ReadNode(FilterGroup)`, `Create(UserInputDto[])`, `Update(UserInputDto[])`, `Delete(int[])`, `SetRoles(UserSetRoleDto)`, `SetModules(UserSetModuleDto)` |
| `Role` | `Read(PageRequest)`, `ReadNode()`, `ReadUserRoles(int userId)`, `Create(RoleInputDto[])`, `Update(RoleInputDto[])`, `Delete(int[])`, `SetModules(RoleSetModuleDto)` |
| `UserRole` | `Read(PageRequest)`, `Update(UserRoleInputDto[])`, `Delete(Guid[])` |
| `LoginLog` | `Read(PageRequest)`, `Delete(Guid[])` |

Reads return framework query/page envelopes. Writes are POST operations and generally combine `[ModuleInfo]`, `[DependOnFunction(nameof(Read))]`, and `[UnitOfWork]`; preserve that pattern in equivalent custom controllers.

## Prerequisites and safety

- Identity persistence requires `IdentityPack` and the selected EF provider/migration chain.
- Cookie/JWT/OAuth middleware and token services require `AuthenticationPack`.
- Admin function checks require `FunctionAuthorizationPack`; module assignment also uses authorization metadata.
- Never put JWT, OAuth, or mail secrets in committed JSON or request examples.

## Evidence anchors

- `src/OSharp.Hosting.Core/Identity/IIdentityContract.cs`
- `src/OSharp/Identity/JwtBearer/IJwtBearerService.cs`
- `src/OSharp.Hosting.Apis/Controllers/IdentityController.cs`
- `src/OSharp.Hosting.Apis/Areas/Admin/Controllers/Identity`


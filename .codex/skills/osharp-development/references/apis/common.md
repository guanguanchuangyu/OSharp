# HTTP API conventions

## Route and controller conventions

`OSharp.Hosting.Apis` uses conventional controller/action routing. Public site controllers resolve as `/<Controller>/<Action>`; controllers under the `Admin` area resolve as `/Admin/<Controller>/<Action>`. Preserve action names when calling built-in APIs. Do not invent REST-style routes unless the target project deliberately replaces the framework convention.

`SiteApiControllerBase` is the public base. `AdminApiControllerBase` adds the `Admin` area, role restriction, and API authorization. Admin endpoints therefore require the identity/authentication and function-authorization chain to be active.

## Common request and response shapes

- `PageRequest` carries paging, sorting, and filtering information for list endpoints.
- `PageData<T>` is the paged result shape returned by most `Read` actions.
- `FilterGroup` is the framework filter tree used by entity/data authorization; validate its member/property names against registered entity metadata.
- `AjaxResult` is the controller response envelope for operation status, message, and returned data.
- Business contracts generally return `OperationResult` or `OperationResult<T>`; controllers translate these into `AjaxResult`. Keep this boundary when writing custom controllers.

## Action attributes

- `[HttpGet]` is used for reads and checks; `[HttpPost]` is used for login and writes.
- `[ModuleInfo]` contributes module/function discovery metadata.
- `[DependOnFunction(nameof(Read))]` makes a write action depend on its controller's read permission.
- `[UnitOfWork]` defines the transaction boundary around state-changing operations.
- `[LoggedIn]` explicitly requires an authenticated principal on public-site actions.
- Admin controller bases already enforce the admin-area security boundary; do not weaken it on derived controllers.

## Public common endpoints

| Method | Route | Input | Result | Notes |
|---|---|---|---|---|
| GET | `/Common/Captcha` | query `id` | captcha image/result | `[ModuleInfo]`; captcha options must be configured by the identity stack. |
| GET | `/Common/CheckCaptcha` | query `id`, `code` | validity result | `[ModuleInfo]`; never use this as a replacement for server-side validation in protected flows. |
| GET | `/Common/SystemInfo` | none | public system information | `[ModuleInfo]`; review exposed fields before extending it. |
| GET | `/Auth/CheckUrlAuth` | query `url` | authorization result | `[UnitOfWork]`; requires the authorization services. |
| GET | `/Auth/GetAuthInfo` | none | current authorization information | `[ModuleInfo]`; result depends on current principal and registered functions. |

## Evidence anchors

- `src/OSharp.Hosting.Apis/Controllers/CommonController.cs`
- `src/OSharp.Hosting.Apis/Controllers/AuthController.cs`
- `src/OSharp.Hosting.Apis/Controllers/SiteApiControllerBase.cs`
- `src/OSharp.Hosting.Apis/Areas/Admin/Controllers/AdminApiControllerBase.cs`


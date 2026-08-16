# Systems APIs

Read this with [SystemsPack](../packs/hosting/systems.md). All endpoints are under `/Admin/<Controller>/<Action>` and inherit the admin authorization boundary.

| Controller | Method/action | Input | Purpose |
|---|---|---|---|
| `Menu` | GET `Read` | `PageRequest` | Page menu records. |
| `Menu` | POST `Create` | `MenuInputDto[]` | Create menu records. |
| `Menu` | POST `Update` | `MenuInputDto[]` | Update menu records. |
| `Menu` | POST `Delete` | `int[]` | Delete menu records. |
| `Settings` | GET `Read` | query `root` | Return a `SettingOutputDto` tree rooted at the requested options path. |
| `Settings` | POST `Update` | `SettingInputDto` | Persist supported settings through the framework setting manager. |
| `Pack` | GET `Read` | `PageRequest` | Inspect discovered Pack state. |

Menu writes are transactional and depend on menu read permission. Settings can include security-sensitive operational values: expose only approved paths, redact secrets from responses/logs, and use external secret providers for credentials. Pack inspection is diagnostic; it does not authorize runtime installation of arbitrary local Packs.

`ISystemsContract` exposes menu query/check/create/update/delete operations for service-layer use. Prefer that contract over direct repository access.

## Evidence anchors

- `src/OSharp.Hosting.Core/Systems/ISystemsContract.cs`
- `src/OSharp.Hosting.Apis/Areas/Admin/Controllers/Systems/MenuController.cs`
- `src/OSharp.Hosting.Apis/Areas/Admin/Controllers/Systems/SettingsController.cs`
- `src/OSharp.Hosting.Apis/Areas/Admin/Controllers/Systems/PackController.cs`


# Function and data authorization APIs

Read this with [FunctionAuthorizationPack](../packs/security/function-authorization.md), [DataAuthorizationPack](../packs/security/data-authorization.md), and the [authorization workflow](../workflows/authorization.md).

All listed endpoints are admin endpoints with conventional routes `/Admin/<Controller>/<Action>`. `Read*` actions are GET; mutations are POST and normally use `[UnitOfWork]` plus `[DependOnFunction(nameof(Read))]`.

## Entity metadata and functions

| Controller | Actions and inputs | Purpose |
|---|---|---|
| `EntityInfo` | `Read(PageRequest)`, `ReadNode()`, `ReadProperties(string typeName)`, `Update(EntityInfoInputDto[])` | Inspect and manage registered entity/property metadata used by data filters. |
| `Function` | `Read(PageRequest)`, `ReadTreeNode(int moduleId)`, `Update(FunctionInputDto[])` | Inspect discovered controller functions and maintain function metadata. |
| `Module` | `Read()`, `ReadUserModules(int userId)`, `ReadRoleModules(int roleId)`, `ReadFunctions(int moduleId, PageRequest)`, `Create(ModuleInputDto)`, `Update(ModuleInputDto)`, `Delete(int id)`, `SetFunctions(ModuleSetFunctionDto)` | Build the module tree and associate functions/users/roles. |

## Assignments and filters

| Controller | Actions and inputs | Purpose |
|---|---|---|
| `RoleEntity` | `Read(PageRequest)`, `Create(EntityRoleInputDto[])`, `Update(EntityRoleInputDto[])`, `SetFilterGroup(Guid id, FilterGroup)`, `Delete(Guid[])` | Assign entity access to roles and persist the role filter tree. |
| `RoleFunction` | `Read(PageRequest)`, `ReadFunctions(int roleId, PageRequest)` | Inspect role/function grants. |
| `UserFunction` | `Read(PageRequest)`, `ReadFunctions(int userId, PageRequest)` | Inspect user/function grants. |

## Service/API boundary

Controller actions are management surfaces, not substitutes for application-level authorization checks. Function authorization consumes discovered action metadata and the current principal. Data authorization applies registered entity metadata and `FilterGroup` rules to queries. Custom business services should keep query authorization near the query composition and retain controller attributes for endpoint discovery/permission dependencies.

Validate property names and operators before saving `FilterGroup`; stale metadata can make a filter invalid or broader than intended. Test both allowed and denied principals, plus empty/no-grant cases.

## Evidence anchors

- `src/OSharp.Hosting.Apis/Areas/Admin/Controllers/Auth`
- `src/OSharp.Authorization.Functions`
- `src/OSharp.Authorization.Datas`
- `src/OSharp.Entity`


# Authorization workflow

## Function authorization

1. Activate Identity, Authentication, and FunctionAuthorization through the existing Pack chain.
2. Derive controllers from the correct site/admin base.
3. Add `[ModuleInfo]` to discoverable actions and use stable controller/action names.
4. Use `[DependOnFunction(nameof(Read))]` for writes that should share the read function's grant.
5. Start the application so module/function metadata is discovered, then use the [authorization APIs](../apis/authorization.md) to inspect functions and assign them to modules, roles, and users.
6. Test an allowed principal, a denied principal, and an unauthenticated request.

## Data authorization

1. Activate EntityInfo and DataAuthorization and ensure the entity/mapping is registered.
2. Inspect the entity and property metadata through `/Admin/EntityInfo/*`.
3. Create the role/entity association, then save a validated `FilterGroup` through `RoleEntity/SetFilterGroup`.
4. Apply the framework data filter to service queries before materialization/paging.
5. Test no-grant, matching-row, nonmatching-row, and malformed/stale-property cases.

Function grants answer whether a principal may call an operation. Data filters answer which rows that permitted operation may see. Implement and test both independently. Never trust a client-supplied filter as the authorization rule, and never broaden access when metadata or parsing fails.

Relevant references: [EntityInfoPack](../packs/security/entity-info.md), [FunctionAuthorizationPack](../packs/security/function-authorization.md), [DataAuthorizationPack](../packs/security/data-authorization.md), and [Identity APIs](../apis/identity.md).


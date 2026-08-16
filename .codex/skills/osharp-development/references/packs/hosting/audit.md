# AuditPack

## Purpose
Capture operation/entity audit events and persist/query audit operations, entities, and properties.

## Official NuGet acquisition
Concrete Pack: `OSharp.Hosting.Core`, supplied transitively through `OSharp.Hosting.Apis`.

## Pack type and activation
Namespace/type: `OSharp.Hosting.Systems.AuditPack`, based on `AuditPackBase`. Registered by the G2Cy template.

## Effective Pack dependencies
`EventBusPack`; Application level.

## Registered services
Transient audit event handler from the base; scoped `IAuditStore -> AuditDatabaseStore` and `IAuditContract -> AuditService`.

## Lifecycle behavior
Auditable operations/entities publish events that the Pack stores through the active unit of work/database.

## Configuration
Entity auditing is enabled per DbContext with `OSharp:DbContexts:<name>:AuditEntityEnabled`. No separate Audit section.

## Injectable service APIs
`IAuditContract` queries/deletes operation and entity audit records; `IAuditStore` records events.

## Related HTTP APIs
Admin AuditOperation and AuditEntity read endpoints; see [audit API](../../apis/audit.md).

## Extension points and project placement
Apply audit attributes/conventions in Core and keep audit persistence in the selected database. Avoid recording secrets or oversized payloads.

## Common mistakes and verification
Enabling entity audit without hosting mappings/migrations causes storage failures. Verify transaction consistency and sensitive-field handling.

## Evidence anchors
`src/OSharp.Hosting.Core/Systems/AuditPack.cs`; `src/OSharp/Audits/AuditPackBase.cs`; `IAuditContract.cs`; hosting audit controllers.

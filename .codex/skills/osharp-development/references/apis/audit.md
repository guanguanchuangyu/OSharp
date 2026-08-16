# Audit APIs

Read this with [AuditPack](../packs/hosting/audit.md). Routes are conventional admin routes.

| Method | Route | Input | Result |
|---|---|---|---|
| GET | `/Admin/AuditOperation/Read` | `PageRequest` | Paged operation-audit records. |
| GET | `/Admin/AuditEntity/Read` | `PageRequest` | Paged entity-audit records, with property detail provided by the audit model. |

`IAuditContract` exposes `AuditOperations`, `AuditEntities`, and `AuditProperties`, plus delete operations for operation/entity audits. The published controllers expose reads in the current baseline; do not advertise contract-only delete methods as HTTP endpoints unless the target application explicitly adds secured controllers for them.

Audit data may contain identifiers, request context, and changed values. Keep admin authorization, apply retention/redaction rules, and never log secrets or authentication tokens. Enable entity auditing only for entities whose change history is required.

## Evidence anchors

- `src/OSharp.Hosting.Core/Systems/IAuditContract.cs`
- `src/OSharp.Hosting.Apis/Areas/Admin/Controllers/Systems/AuditOperationController.cs`
- `src/OSharp.Hosting.Apis/Areas/Admin/Controllers/Systems/AuditEntityController.cs`


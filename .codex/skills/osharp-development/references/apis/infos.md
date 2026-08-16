# Infos and messaging APIs

Read this with [InfosPack](../packs/hosting/infos.md). All endpoints use `/Admin/<Controller>/<Action>` and the admin authorization boundary.

| Controller | GET | POST inputs |
|---|---|---|
| `Message` | `Read(PageRequest)` | `Create(MessageInputDto[])`, `Update(MessageInputDto[])`, `Delete(Guid[])` |
| `MessageReceive` | `Read(PageRequest)` | `Create(MessageReceiveInputDto[])`, `Update(MessageReceiveInputDto[])`, `Delete(Guid[])` |
| `MessageReply` | `Read(PageRequest)` | `Create(MessageReplyInputDto[])`, `Update(MessageReplyInputDto[])`, `Delete(Guid[])` |

Writes depend on the corresponding read function and run in a unit of work. `IInfosContract` exposes queryables, existence checks, and matching create/update/delete operations for the three aggregates.

Some current framework implementations are published in `*.generated.cs` files. They are evidence for the installed Pack contract and HTTP surface only. New G2Cy business code must be hand-written and must not copy or reintroduce the deprecated generator workflow.

## Evidence anchors

- `src/OSharp.Hosting.Core/Infos/IInfosContract.generated.cs`
- `src/OSharp.Hosting.Apis/Areas/Admin/Controllers/Infos`
- `src/OSharp.Hosting.Core/Infos`


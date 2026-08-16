# Validation and update procedure

## Routine validation

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .codex/skills/osharp-development/scripts/audit-source-drift.ps1
powershell -ExecutionPolicy Bypass -File .codex/skills/osharp-development/scripts/test-skill.ps1
```

Then run the Skill Creator `quick_validate.py` against the Skill folder and restore/build a representative generated project for each affected provider or optional Pack.

## Baseline update

1. Compare `Directory.Build.props`, template PackageReferences, template `Startup`, and appsettings.
2. Inventory concrete Pack types and inherited `DependsOnPacks` relationships.
3. Review option classes and configuration reads.
4. Review hosting contracts, controllers, DTOs, and action attributes.
5. Update only affected Pack/API/workflow references and the pinned revision.
6. Run structural checks and representative task evaluations.

## Supported scope

The catalog covers the 32 Pack/reference files listed in `packs/index.md`, official NuGet consumption, the five template database providers, default hosting APIs, and hand-written business development. Local custom Packs, framework source customization, WPF, and the deprecated generator workflow are excluded.

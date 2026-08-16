# Validated baseline

- Target framework: `net10.0`.
- OSharp package line: `10.0.0`, supplied through `$(OSharpVersion)`.
- Template: `templates/G2Cy.OSharp.Templates`.
- Template short name: `g2cy-api`; default database: `mysql`.
- Source revision used for these references: `72aa44909d7ffab2d9fde09249b585053668dbeb` on `master`.
- Baseline captured: 2026-08-16.

## Source precedence

1. Use `templates/G2Cy.OSharp.Templates` for target framework, project structure, direct NuGet references, safe configuration, and default Pack registration.
2. Use `samples/web` for current application API usage and hand-written extension patterns.
3. Use `src` to verify Pack behavior, dependency attributes, configuration binding, DI registrations, service contracts, controllers, DTOs, and attributes.
4. Use `docs/old-template` only for historical comparison. Never copy its package versions or generator workflow.

Framework source projects reference one another because they build NuGet packages. Those references are evidence, not target-application instructions.

## Package policy

- Put the shared version in `Directory.Build.props`:

```xml
<OSharpVersion>10.0.0</OSharpVersion>
```

- Reference built-in framework components through official package IDs and `Version="$(OSharpVersion)"`.
- Prefer the direct references already present in the G2Cy template. Add optional packages only when their Pack is selected.
- Do not add a redundant direct package when the required type is already supplied transitively and the generated solution builds.
- Never point a target application at a repository `src/OSharp*` project.

## Known compatibility note

The OSharp 10.0.0 MySQL package currently brings `Pomelo.EntityFrameworkCore.MySql 9.0.0`. A `net10.0` generated MySQL solution builds, but restore reports `NU1608` because Pomelo declares EF Core Relational support through 9.x while EF Core 10.x is resolved. Do not hide this warning. Re-test it when the official MySQL dependency changes.

## Update rule

Treat any target-framework, OSharp-version, template dependency, Pack catalog, or public API update as a coordinated baseline change. Run both scripts in `scripts/` and representative generated-project builds before changing this file.

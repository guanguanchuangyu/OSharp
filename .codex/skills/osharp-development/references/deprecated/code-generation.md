# Deprecated target-project code generation

Do not use `OSharp.CodeGeneration`, generator Razor templates, one-time generated partials, or target-project files ending in `.generated.cs`.

The framework and historical sample contain generated artifacts because they expose already-published framework APIs and older workflows. Read them only to understand an existing contract, controller action, DTO, or mapping. Do not copy their generator headers, partial-extension instructions, or source-generation dependencies into a G2Cy project.

When modernizing legacy code:

1. Identify the public contract and behavior that must remain.
2. Create a normal hand-written contract, implementation, DTO, entity configuration, or controller in the correct G2Cy layer.
3. Remove generator package references and generation instructions from the target project.
4. Rename or replace generated target files with normal `.cs` files.
5. Build and exercise the affected API before deleting obsolete legacy files.

Do not modify published framework source merely to remove its historical generated files.

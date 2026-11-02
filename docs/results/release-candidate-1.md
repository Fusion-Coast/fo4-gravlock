# Release candidate 1.0.0 (2026-11-01): package test — PASS

Installed from `FO4GravLock-1.0.0.zip` (plugin + compiled scripts + source), development copies removed.

- Light plugin (ESL flag): loads as FE-prefixed (quest FE009F99); lists built and cars locked with logging on.
- Packaging issues found and fixed during testing:
  1. First ZIP was missing the `.pex` files in `Scripts\` ("Cannot open store for class GravLock_*").
  2. 7-Zip extracted into a subfolder (the "Extract to" path had the archive name appended).
  3. Logging stayed on in the test save: a plain `Auto` property's value is stored in the save. Fixed by making
     `DebugLogging` `Auto Const`.
- Final log: **zero GravLock lines** (scripts load, logging off, no errors).
- In game: about a dozen cars run into (the 30-car dump site, some clipped into objects, some not): **all
  steady, no issues.**
- Stray `FO4GravLock.tes` in Data: Creation Kit temp file from the interrupted save. Not part of the package.

Remaining before upload: Nexus page.

## Compatibility: Unofficial Fallout 4 Patch — COMPATIBLE
FO4Edit with Fallout4.esm, all DLC, Unofficial Fallout 4 Patch.esp and FO4GravLock.esp; Apply Filter to show
Conflicts. **FO4GravLock.esp didn't appear in the filtered tree at all**: none of the 64 vehicle records (or the
quest) are touched by UFO4P. The only result was an unrelated UFO4P navmesh override of DLCCoast
(NAVM 00218D3F). Mod page: compatible with UFO4P; load Grav Lock after it and after any mod that edits
vehicles.

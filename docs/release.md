# Release guide (Nexus, PC)

Do these in order. Only one tool open at a time (Creation Kit **or** FO4Edit, never both).

Shortcuts: **Game folder** = Steam > right-click Fallout 4 > Manage > Browse local files.
**FO4Edit folder** = the folder with `FO4Edit.exe`.

---

## 1. Turn test logging off

**Where:** Game folder > `Data\Scripts\Source\User\` > open `GravLock_ConfigScript.psc` in Notepad.

1. **Ctrl + Home**, then **Ctrl + F** for `DebugLogging`.
2. The line must read exactly `bool Property DebugLogging = false Auto Const` (false, and **Const**: without
   Const, a save made during testing remembers `true`). Save, close Notepad.
3. Open the Creation Kit > **File > Data** > check only `Fallout4.esm` > **OK** (don't load the plugin; nothing to
   save).
4. **Gameplay > Papyrus Script Manager** > right-click `GravLock_ConfigScript` > **Compile**. Close the Creation
   Kit (if it asks to save, **No**).

(The repo copy is already `false`.)

Optional, for your own game: remove the `[Papyrus]` logging lines from
`Documents\My Games\Fallout4\Fallout4Custom.ini`. That's your setting, not part of the mod.

## 2. Make it a light plugin (ESL flag), optional but recommended

A light plugin doesn't use one of the 254 regular plugin slots. Allowed because the plugin only adds one new
record (the quest, ID `000F99`, inside the light range `000800`-`000FFF`); the 64 vehicle edits don't count.

**Where:** FO4Edit, with only `FO4GravLock.esp` checked.

1. In the left pane, click **`FO4GravLock.esp`** itself (the top line), then **File Header** under it.
2. In the right pane, expand **Record Header** > find **Record Flags**.
3. Right-click the value next to **Record Flags** > **Edit**. In the checklist, tick **ESL**. **OK**.
4. Close FO4Edit > keep `FO4GravLock.esp` checked in the save window > **OK**.

**Retest (2 minutes):** launch the game, load a save, push against a few cars: they shouldn't move. The plugin
still loads from `plugins.txt` the same way (`*FO4GravLock.esp`).
Tip: do this step **before** step 1 if you want log proof (with logging still on, the log should show "lists
built" and the cars' "locked after" lines as before).

## 3. Package for Nexus

The mod is three files. A plain ZIP of them is the simplest package, and every mod manager (Vortex, MO2) handles
it.

**a) Make a staging folder** anywhere, e.g. `C:\Modding\Release\FO4GravLock-1.0.0`. Inside it, create the same
structure as the game's `Data` folder:

```
FO4GravLock-1.0.0\
  FO4GravLock.esp
  Scripts\
    GravLock_CarLockScript.pex
    GravLock_ConfigScript.pex
    Source\User\                  (optional: lets others read the scripts)
      GravLock_CarLockScript.psc
      GravLock_ConfigScript.psc
```

**b) Copy the files in** from the Game folder:
- `Data\FO4GravLock.esp`
- `Data\Scripts\GravLock_CarLockScript.pex` and `Data\Scripts\GravLock_ConfigScript.pex` (the compiled scripts;
  check their **Date modified** is from after step 1)
- Optional: the two `.psc` files from `Data\Scripts\Source\User\`

**c) Zip the contents, not the folder:** open `FO4GravLock-1.0.0`, select **everything inside it** (Ctrl + A) >
right-click > **Send to > Compressed (zipped) folder**. Rename the ZIP to `FO4GravLock-1.0.0.zip`.
(Opening the ZIP should show `FO4GravLock.esp` and `Scripts` right at the top.)

**d) Test the package like a player would:**
1. Move your development copies out of the way: from `Data`, move `FO4GravLock.esp` and the two
   `GravLock_*.pex` files to a backup folder.
2. Extract the ZIP into `Data` (or install it with a mod manager).
3. Launch, load a save, push against a car: it shouldn't move.
4. Put your development copies back afterward if you'll keep developing (or keep using the extracted ones; they
   are the same files).

(Optional: scripts can also be packed into a `.ba2` archive named `FO4GravLock - Main.ba2` with the Archive2 tool
in `Fallout 4\Tools\Archive2\`. Tidier, but not needed for three small files.)

## 4. Compatibility check

Any mod that edits the same 64 vehicle records conflicts with Grav Lock: whichever loads last wins that record.
The one worth checking first is the **Unofficial Fallout 4 Patch (UFO4P)**, which most players use.

**a) Get UFO4P** from its Nexus page and extract it into `Data` temporarily (or install with a mod manager).

**b) Load both in FO4Edit:** check `FO4GravLock.esp` and `Unofficial Fallout 4 Patch.esp` > **OK**. Wait for
"Background Loader: finished".

**c) Show only conflicts:** right-click the left pane > **Apply Filter to show Conflicts** > wait.

**d) Read the result:**
- Expand **`FO4GravLock.esp` > Moveable Static**. If **nothing is listed** (or the group is gone), no vehicle is
  edited by both mods: **compatible**.
- If some vehicles are listed, click one: the right pane shows columns for each file. If UFO4P changes a
  field there, its fix would be overwritten by Grav Lock. Screenshot it: the fix is a small compatibility patch
  that carries UFO4P's change into Grav Lock's copy.

**e) Clean up:** remove UFO4P from `Data` again if you don't want it installed (or keep it; it's a good mod).

**Load order advice for the mod page:** load Grav Lock **after** the Unofficial Patch and any mod that changes
vehicles.

Repeat (b)-(d) with any other popular mod you suspect edits cars (e.g. settlement or "scrap everything" mods).

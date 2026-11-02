# Build guide: FO4GravLock.esp

Every step says **where to go** first, then **what to do**.

## Shortcuts used below

| Name | How to open it |
|---|---|
| **Game folder** | Steam > Library > right-click **Fallout 4** > **Manage** > **Browse local files**. A folder called `Fallout 4` opens. |
| **Load order folder** | Press **Windows key + R**, type `%LOCALAPPDATA%\Fallout4`, press Enter. `plugins.txt` is in here. |
| **Repo download** | Go to github.com/Fusion-Coast/fo4-gravlock > green **Code** button > **Download ZIP**. Right-click the ZIP in Downloads > **Extract All** > **Extract**. Open the new folder, then the `fo4-gravlock-main` folder inside it. |
| **Open a text file in Notepad** | Right-click the file > **Open with** > **Notepad** (on Windows 10 you may need **Choose another app** first). |
| **Object Window** (Creation Kit) | The panel with a category tree on the left and a list on the right. If it's hidden: **View** menu > **Object Window**. |
| **Script Manager** (Creation Kit) | **Gameplay** menu > **Papyrus Script Manager**. |

---

## 0. Remove the prototype

**a) Load order:** open the **Load order folder** > open `plugins.txt` in Notepad > delete the line
`*FO4GravLock_Proto.esp` > **File > Save** > close Notepad.

**b) Prototype plugin:** open the **Game folder** > open `Data` > delete `FO4GravLock_Proto.esp`.

**c) Prototype compiled script:** still in `Data`, open `Scripts` > delete `GravLock_ProtoLock.pex`.

**d) Prototype source script:** still in `Scripts`, open `Source` > `User` > delete `GravLock_ProtoLock.psc`.
Keep this window open for step 1.

## 1. Copy in the new scripts

**Where:** the **Repo download** (fresh copy, so it has the new scripts) > `Data` > `Scripts` > `Source` > `User`.

**Do:** copy **`GravLock_ConfigScript.psc`** and **`GravLock_CarLockScript.psc`**, and paste them into the
game's `Data\Scripts\Source\User` folder from step 0d. If Windows asks about replacing
`GravLock_CarLockScript.psc`, choose **Replace**.

## 2. Start a new plugin

**Where:** Steam > Library > **Fallout 4: Creation Kit** > **Play**.

**Do:**
1. **File** menu > **Data...**
2. In the list, double-click **`Fallout4.esm`** so it has a check mark. Nothing else checked. Don't click
   "Set as Active File".
3. **OK**. Wait for loading to finish (click **Yes to All** on any warning pop-ups).

## 3. Compile both scripts

**Where:** **Script Manager**.

**Do:**
1. Type `GravLock` in its filter box.
2. Right-click **`GravLock_ConfigScript`** > **Compile**. Wait for it to finish.
3. Right-click **`GravLock_CarLockScript`** > **Compile**.
4. If an error window appears, screenshot it and keep it for troubleshooting. Otherwise close the Script Manager.

## 4. Create the config quest

A Creation Kit "quest" is just a container for a background script. This one has no journal entry, objectives,
markers or messages: the player never sees it.

**Where:** **Object Window** > in the left tree, expand **Character** > click **Quest**.

**Do:**
1. Right-click anywhere in the **list on the right** > **New**. A quest window opens.
2. At the top, in the **ID** box, type `GravLock_Config`.
3. On the **Quest Data** tab (the first tab), check **Start Game Enabled**. Leave everything else alone.
4. Click **OK** at the bottom.
5. Back in the Object Window list, type `GravLock` in the **Filter** box (top of the Object Window).
   Double-click **GravLock_Config** to reopen it.
6. Click the **Scripts** tab (one of the tabs along the top of the quest window).
7. Click **Add** > pick **`GravLock_ConfigScript`** > **OK**.
8. Turn on test logging (writes to the Papyrus log only, never on screen). The Properties window may not
   offer an Edit Value option for it, so do it in the script instead: open
   `Data\Scripts\Source\User\GravLock_ConfigScript.psc` in Notepad, press **Ctrl + Home**, then **Ctrl + F**
   for `DebugLogging`. Change `bool Property DebugLogging = false Auto` to `= true`, save, and recompile
   `GravLock_ConfigScript`. **Set it back to `false` before release** (see the release checklist).
9. Click **OK** to close the quest window.
10. In the Object Window list, look at the **FormID** column next to GravLock_Config (e.g. `01000F99`).
    Write down the **last six characters** (e.g. `000F99`).

## 5. Save the plugin

**Where:** Creation Kit **File** menu.

**Do:** **File > Save**. It asks for a name: type `FO4GravLock.esp` > **Save**. (Later saves don't ask.)

## 6. Point the car script at the quest

**Where:** **Game folder** > `Data` > `Scripts` > `Source` > `User` > open `GravLock_CarLockScript.psc` in
Notepad.

**Do:**
1. Press **Ctrl + F**, search for `ConfigQuestID`.
2. On that line, replace `000800` with the six characters from step 4.10, keeping `0x` in front.
   Example: `int Property ConfigQuestID = 0x000F99 Auto Const`
3. **File > Save**, close Notepad.
4. Back in the Creation Kit: **Script Manager** > right-click `GravLock_CarLockScript` > **Compile**.
5. Update the same line in the repo copy of the script, so the two match.

## 7. Attach the car script to all 64 vehicles

### Option A (recommended): automatic, with FO4Edit

1. **Get the script:** in the repo, open `tools/GravLock_AttachCarScript.pas` > **Download raw file**.
2. **Put it in FO4Edit's scripts folder:** open the folder where `FO4Edit.exe` is (e.g. `C:\Modding\FO4Edit`) >
   open **`Edit Scripts`** > paste the file there.
3. **Close the Creation Kit** (both tools must not have the plugin open at once).
4. **Open FO4Edit.** In the plugin list: right-click > **Select None** > check **`FO4GravLock.esp`** > **OK**.
   Wait for the left pane to fill in.
5. In the left pane, **right-click `FO4GravLock.esp`** > **Apply Script...**
6. In the window that opens, pick **`GravLock_AttachCarScript`** from the dropdown at the top > **OK**.
7. Read the **Messages** pane on the right. It lists each vehicle, then ends with
   **"64 of 64 vehicles have the script (64 new, 0 already done, 0 problems)."**
   Any MISSING or FAILED line: screenshot it.
8. **Close FO4Edit.** A save window appears: make sure **`FO4GravLock.esp`** is checked > **OK**.
9. Check: reopen FO4Edit with `FO4GravLock.esp`. Under it there's now a **Moveable Static** group with 64
   vehicles; click one: its **VMAD** line lists `GravLock_CarLockScript`.

### Option B: by hand in the Creation Kit

**Where:** **Object Window** > in the left tree, expand **WorldObjects** > click **MovableStatic**.

**Do, for each vehicle in the checklist:**
1. Type its name in the Object Window **Filter** box (e.g. `CarSedan01`), or a group name (`CarSedan`) to list all
   of them.
2. Double-click it.
3. In the window that opens, find the **Scripts** box > **Add** > pick **`GravLock_CarLockScript`** > **OK**.
4. **OK** to close the vehicle window. No properties to fill.

Every 10 vehicles: **File > Save**.

**Cars (48)**
- [ ] CarMini01Prewar  - [ ] CarMini01
- [ ] CarSedan01  - [ ] CarSedan02  - [ ] CarSedan03  - [ ] CarSedan04  - [ ] CarSedan05  - [ ] CarSedan06
- [ ] CarSedan07  - [ ] CarSedan08  - [ ] CarSedan09  - [ ] CarSedan10  - [ ] CarSedan11
- [ ] CarSportsCar01  - [ ] CarSportsCar02  - [ ] CarSportsCar03  - [ ] CarSportsCar04  - [ ] CarSportsCar05
- [ ] CarSportsCar06  - [ ] CarSportsCar07  - [ ] CarSportsCar08  - [ ] CarSportsCar09  - [ ] CarSportsCar10
- [ ] CarSportsCar11
- [ ] CarFusionFlea01Clean  - [ ] CarFusionFlea01
- [ ] CarCoupe01  - [ ] CarCoupe02  - [ ] CarCoupe03  - [ ] CarCoupe04  - [ ] CarCoupe05  - [ ] CarCoupe06
- [ ] CarCoupe07  - [ ] CarCoupe08  - [ ] CarCoupe09  - [ ] CarCoupe10  - [ ] CarCoupe11
- [ ] CarStationWagon01  - [ ] CarStationWagon02  - [ ] CarStationWagon03  - [ ] CarStationWagon04
- [ ] CarStationWagon05  - [ ] CarStationWagon06  - [ ] CarStationWagon07  - [ ] CarStationWagon08
- [ ] CarStationWagon09  - [ ] CarStationWagon10  - [ ] CarStationWagon11

**Pickup trucks (11)**
- [ ] PickUpTruck01  - [ ] PickUpTruck02  - [ ] PickUpTruck03  - [ ] PickUpTruck04  - [ ] PickUpTruck05
- [ ] PickUpTruck06  - [ ] PickUpTruck07  - [ ] PickUpTruck08  - [ ] PickUpTruck09  - [ ] PickUpTruck10
- [ ] PickUpTruck11

**Vault-Tec vans (5)**
- [ ] VaultTecVan01  - [ ] VaultTecVan02  - [ ] VaultTecVan01Prewar  - [ ] VaultTecVan01Blue
- [ ] VaultTecVan02Blue

**Not these:** Truck01/02/03 in any color (box trucks, out of scope).

When done: **File > Save**, then close the Creation Kit.

## 8. Turn it on

**Where:** **Load order folder** > open `plugins.txt` in Notepad.

**Do:** add `*FO4GravLock.esp` as a new line at the bottom > **File > Save** > close Notepad.

## 9. First check in the game

**Where:** launch Fallout 4 from Steam, load a save.

**Do:**
1. Nothing appears on screen (that's intended).
2. Go to the **Quincy Red Rocket car**. It should be still when you arrive. Rub against it: no movement.
3. Quit, then open the log: **Windows key + R**, type
   `%USERPROFILE%\Documents\My Games\Fallout4\Logs\Script`, Enter > `Papyrus.0.log`.
   Check it for **"GravLock: lists built: 11 explosive keywords, 5 non-moving keywords, 27 explosions,
   2 strong keywords, 1 strong races"** (38 explosions with Nuka-World), any **"MISSING"** lines, and the
   lock / free lines from the cars.

---

## Release checklist (before packaging for Nexus / Creations)

- [x] `GravLock_ConfigScript.psc`: `bool Property DebugLogging = false Auto Const`, recompiled (RC1)
- [x] Full test plan (`docs/testing.md`) passed, including the 30+ car stress test (build runs 1-4, RC1)
- [x] Plugin's only master is `Fallout4.esm`; ESL-flagged (RC1)
- [ ] Mod page tagged **AI-Generated Content**, with the credits line (design, research and testing by Fusion Coast)
- [ ] `docs/prior-art.md` re-checked for new competing mods
- [x] Compatible with the Unofficial Fallout 4 Patch (no shared records, RC1)

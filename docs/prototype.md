# Prototype plan

**Goal:** prove that locking a car stops the death bug before building the full mod. One car model
(CarSedan01), one small script (`GravLock_ProtoLock.psc`), one evening.

**Go / no-go:** if you can't get killed or moved by a locked sedan (Test A), the project is proven. If you
still can, stop and rethink before building anything else.

The prototype also answers the open questions from the main script's "Unknowns to test" list.

---

## 0. Before you start

- [ ] Old setup backed up (game folder, `Documents\My Games\Fallout4`, `%LOCALAPPDATA%\Fallout4`, mod manager)
- [ ] Fresh, current Fallout 4 installed from Steam, launched once to the main menu
- [ ] **No other mods** enabled for the prototype
- [ ] Creation Kit installed from Steam (Library > Tools > Fallout 4: Creation Kit)
- [ ] Repo files on your gaming PC (download the repo as a ZIP from GitHub, or clone it)

**Turn on script logging** so the prototype's messages are also saved to a file. Add this to
`Documents\My Games\Fallout4\Fallout4Custom.ini` (create the file if it doesn't exist):

```ini
[Papyrus]
bEnableLogging=1
bEnableTrace=1
bLoadDebugInformation=1
```

The log appears at `Documents\My Games\Fallout4\Logs\Script\Papyrus.0.log` after you play.

## 1. Baseline: make the bug happen in the unmodded game

We need a reliable way to trigger the bug, or a passing test proves nothing. Time-box this to about 30 minutes.

**Done (2026-10-31):** reproduced at the Quincy-area Red Rocket (car rattling against a gas pump hose). See
docs/research/README.md. The steps below are kept for reference.

1. Start a new game (or load an early save) and go to **Sanctuary Hills**, which has plenty of parked cars.
2. Make a save right there. Reload it after every death.
3. Try each method about 10 times per car, and write down the results:
   - sprint into the car from different angles, including the corners
   - walk slowly along its side, brushing against it
   - jump onto the hood or roof, then off again
   - melee it, and bayonet it if you have a bayonet weapon (your earlier observation)
   - all of the above in power armor
4. Note which method and which car killed you or moved the car, if any.

**If you can't trigger it at all:** that's useful information. Note it, and do Test A anyway, watching
whether the car moves even a little. Movement is the cause of the bug, so a car that can't budge is the proof.

## 2. Create the plugin

1. Launch the Creation Kit from Steam. On first launch it may offer to extract the game's script sources:
   say yes. (Scripts need them to compile. If it doesn't offer, look for a zip in `Data\Scripts\Source` and
   extract it there.)
2. **File > Data**, check `Fallout4.esm`, click OK, and wait for it to load.
3. Copy `GravLock_ProtoLock.psc` from the repo into `Fallout 4\Data\Scripts\Source\User\`.
4. **File > Save**, name it `FO4GravLock_Proto.esp`.

## 3. Attach the script to CarSportsCar07 (the Quincy car) and CarSedan01

Do these steps for **both** models: **CarSportsCar07** (`001A3051`, the Quincy car, for Test A) and
**CarSedan01** (`00194634`, for the spawned-car tests).

1. In the **Object Window**, go to **WorldObjects > MovableStatic** and find the model.
2. Double-click it to open it. Look for a **Scripts** section and click **Add**.
   - If the dialog has no Scripts section, stop here. FO4Edit can add the script instead.
3. Choose `GravLock_ProtoLock`. If it isn't listed, compile it first: **Gameplay > Papyrus Script Manager**,
   find it, right-click > Compile. Errors show in a window: save them for troubleshooting.
4. With the script added, select it and click **Properties**:
   - `WeaponTypeExplosive`: pick `WeaponTypeExplosive`
   - `ExplodeStage`: leave at 3
5. OK out, then **File > Save**.
6. Enable `FO4GravLock_Proto.esp` (in the game's Mods menu, or your mod manager), then launch the game.

**Getting a test car:** every CarSedan01 and CarSportsCar07 now has the script. For Tests B to E, the easiest
way is to spawn a fresh sedan right next to you. Stand on flat open ground, open the console (`~`) and type:

```
player.placeatme 00194634
```

A sedan appears and the message **"GravLock proto: LOCKED"** should show at the top left. No message means
the script isn't attached or didn't compile: stop and check step 3.

## 4. Tests

Make a save before each test. Write down every on-screen message (or read them from the Papyrus log
afterward).

### Test A: the Quincy Red Rocket car (the go / no-go test)
This car spawns overlapping a gas pump hose, rattles constantly, and killed you in the baseline test.
The script must be on **CarSportsCar07** (step 3).
- [ ] When you arrive, the car is still (no rattling) and "LOCKED" shows
- [ ] Rub against it for at least 2 minutes, from every side: it never moves, and you never die
- [ ] Repeat the other baseline methods (sprint, jump, melee, bayonet, power armor) on it
- [ ] Also try a spawned sedan and a parked Sanctuary sedan: never move

**Quincy car:** reference 001D9517 = **CarSportsCar07 (001A3051)**. Overlapping hose: 001F81D6.

### Test B: the car's own explosion
Shoot the sedan with a normal gun until it catches fire (warning icon), then back away and watch.
- [ ] Write down every "stage X -> Y" message. **Which number shows when it actually explodes?**
- [ ] While it's burning (before the big blast), walk into it: does it stay put?
- [ ] Does "FREED (own explosion...)" appear at the moment of the blast?
- [ ] **Does the explosion still throw or flip the car?** (If not, the timing backup is needed)

### Test C: explosions from outside
Spawn a fresh sedan. Throw a frag grenade at it. Then spawn another and fire a missile at it.
- [ ] Write down the "hit by ..." message: does it say **WEAPON** or **EXPLOSION**, and what's named?
- [ ] Does "FREED (explosive hit)" appear?
- [ ] Does the car get thrown? (Timing again)
- [ ] Shoot a fresh sedan with a normal gun once: message should say WEAPON, and the car stays locked

### Test D: strong enemies (do this last, it gets messy)
Spawn a sedan, back off, then spawn a behemoth nearby with `player.placeatme 0012B97E` (LvlSMBehemoth).
For a deathclaw, find a deathclaw NPC ID in FO4Edit (e.g. search "LvlDeathclaw") and use that ID.
Use `tgm` (god mode) so they can't kill you, and stand so they attack you near the car.
- [ ] Does a hit on the car show a "hit by" message? What does it name?
- [ ] **Does the behemoth ever pick up and throw the locked sedan?** If yes: does the car move freely after?
- [ ] Turn `tgm` off again afterward

### Test E: persistence
- [ ] Walk far away (or fast travel) and come back: "LOCKED" appears again and the car is locked
- [ ] Save next to the car, quit to the main menu, load: still locked

## 5. After the tests

1. Open a new GitHub issue with the **Test run** template and paste in your notes and messages (or the
   relevant lines from `Papyrus.0.log`).
2. Update the real script with what was learned: the true explosion stage number, how explosions
   report themselves, whether the timing backup is needed, and what throwing does.
3. Disable or delete `FO4GravLock_Proto.esp` before building the real mod.

**Prototype limits, on purpose:** no settling (a car spawned in mid-air will freeze there), no approved
explosion list (any explosion frees it), and no re-lock after landing. Those are in the real script; the
prototype only tests the core idea and gathers facts.

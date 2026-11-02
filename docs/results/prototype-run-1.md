# Prototype run 1 (2026-10-31/11-01)

Setup: fresh current Fallout 4 install, no other mods, ~60 fps. FO4GravLock_Proto.esp with
GravLock_ProtoLock on CarSportsCar07 and CarSedan01, loaded as loose files via plugins.txt.

## Test A: Quincy Red Rocket car (CarSportsCar07, ref 001D9517) — PASS (GO)
- Loaded a save from outside the cell, walked up: car was locked to the ground, no rattling.
- Touched / rubbed against it: didn't move at all, no death.
- Baseline (same car, no plugin): rattled against the gas pump hose and killed the player on contact.

## Other observations
- **Molotov:** car caught fire and moved a little. Likely cause: the prototype frees the car on ANY
  explosion hit, and the Molotov arrives as an explosion. The real script only frees on approved
  explosions (Molotov excluded). To confirm in Papyrus.0.log ("hit by EXPLOSION ...").
- **Own explosion:** car didn't move. It was already freed by the Molotov, so this wasn't the timing issue;
  vanilla explosions don't always move cars. Timing still to be tested (Test B, gunfire only).
- **Creations sign-in prompted again** on launch after editing plugins.txt. Harmless; release installs
  through the Creations menu won't do this.
- **Achievements disabled** (hand-installed plugin). Starfield lets Verified Creator Program Creations opt out
  of disabling achievements, and a guide reports FEVer Dreams (Verified) doesn't disable them in Fallout 4.
  Not confirmed for Fallout 4 in general. Release consideration: apply to the Verified Creator Program even
  for a free release, to keep achievements on.
- **Notifications:** dozens of "GravLock proto: LOCKED" messages in a few minutes (one per car of the two
  models as they load). Prototype debug only; the real script shows no notifications.

## Papyrus log findings
- Undamaged cars report destruction stage **-1**. ~14 scripted cars loaded, no stack dumps or overload warnings
  from our script (the log's errors are all vanilla / Creation Club scripts).
- Molotov hit: arrived as a plain **Weapon** hit (Form 0010C3C6), no explosion. It did NOT free the car.
- Then pistol hits (Weapon 00004822, projectile 0001F277) pushed the car into the burn.
- Stage sequence (all from the pistol damage and the self-burn):

| Papyrus | FO4Edit DSTD | What | Time |
|---|---|---|---|
| 0 -> 1 | index 0 (80%) | burn starts | 11:54:24 |
| (hit) | | **Explosion CarExplosion 00022496 hits the car itself** | 11:54:24 |
| 1 -> 2 | index 1 (75%) | small pop | 11:54:24 |
| 2 -> 3 | index 2 (70%) | still burning | 11:54:24 |
| **3 -> 4** | **index 3 (50%)** | **big explosion** | **11:54:29** |
| 4 -> 5 | index 4 | final | 11:55:19 |

- **The car was freed by its own small pop** (CarExplosion), because the prototype frees on any explosion.
  That's the "moved a little". The real script ignores CarExplosion (not approved), so it stays locked.
- **Papyrus stage = DSTD index + 1.** The big explosion is stage **4**, not 3. ExplodeStage fixed to 4 in both
  scripts. With 3, the car would have been freed 5 seconds early, while burning.
- The car's own big explosion does **not** arrive as a hit on itself; the stage change handles it.
- Prototype script updated: ExplodeStage 4, and ignores CarExplosion (new property, fill with 00022496).

## Still to run
- Test B (own explosion, gunfire only): explosion stage number, does the blast throw the freed car?
- Test C (grenade / missile): WEAPON or EXPLOSION, is it thrown?
- Test D (behemoth / deathclaw hits and throwing)
- Test E (persistence)

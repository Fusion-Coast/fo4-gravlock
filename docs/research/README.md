# Research notes

Findings go here before they turn into plugin changes.

## Open questions
1. ~~What record type are car wrecks?~~ **Moveable Static (MSTT).** See car-records.md.
2. What motion type and collision layer do car meshes use? (NifSkope)
3. ~~What does each destruction stage do?~~ Answered for CarSedan01 in car-records.md: burn starts at stage 0
   (80%), big explosion at stage 3 (50%). Still to check: other models, and Papyrus stage numbering.
4. PlayStation: are there vanilla non-physics car meshes to point records at, or a vanilla script that can
   lock physics?
5. Strong enemies, every variant (see the list in testing.md):
   - Which actor-type keywords do deathclaws and behemoths carry? These go in GravLock_StrongActorKeywords.
   - Does every variant (gatorclaw, Swan, DLC, legendary) carry them? Any that don't: add its race to
     GravLock_StrongRaces.
   - ~~How do we attach a script to the creatures?~~ Not needed: run-into shoving was dropped (user decision,
     not a vanilla mechanic). No creature records are edited.
8. ~~Automobiles only~~ Done: 64 records in car-records.md. They get the script (VMAD); no keyword edits needed. Buses, large trucks, heavy equipment and rail are out of scope.
6. ~~Which Explosion forms to exclude?~~ Switched to an approved list (GravLock_MovingExplosions); see explosions.md.
7. Which weapons carry the WeaponTypeExplosive keyword? Confirm it covers every real explosive and no guns.

## Keyword findings (2026-10-31, FO4Edit on an older, pre-2024 game build)

**Explosive weapon types (Fallout4.esm):** WeaponTypeExplosive 0004C922, WeaponTypeThrown 0004A0A6,
WeaponTypeMine 0010C414, WeaponTypeGrenade 0010C415, WeaponTypeCryoMine 00219686, WeaponTypePulseMine
00219687, WeaponTypeNukaMine 00219688, WeaponTypePlasmaMine 00219689, WeaponTypeBottlecapMine 0021968A,
WeaponTypeCryoGrenade 0021968B, WeaponTypeNukaGrenade 0021968C, WeaponTypePlasmaGrenade 0021968D,
WeaponTypePulseGrenade 0021968E, WeaponTypeMolotov 0021A29F, WeaponTypeMissileLauncher 0022575B,
WeaponTypeFatman 0022575C. Also WeaponTypeBroadsider 00225766 (fires cannonballs) and WeaponTypeJunkJet
00225763 (fires junk, not explosive).
- **Decision (user):** count as movers: grenades, mines, missile launcher, Fat Man, Nuka and plasma grenades
  and mines, bottlecap mines, Broadsider. **Not movers, vanilla behavior:** Molotov, cryo and pulse grenades and
  mines. Their damage still counts (Molotov fire burns a car until it explodes, which frees it).
- Explosions now use an approved list (see explosions.md), so Molotov, cryo, pulse and explosive-legendary
  explosions are ignored without listing them.
- Check "Referenced By" on WeaponTypeExplosive to see which weapons carry it.

**Strong enemies:** ActorTypeDeathclaw 000317AA, ActorTypeSuperMutantBehemoth 0014F6A5 (behemoths have their
own keyword, so regular super mutants aren't caught). Other big creatures exist (ActorTypeMirelurkQueen
00108178, ActorTypeMirelurkKing 000E58C7) but are out of scope by user decision.

**Version gap:** the research build predated the April 2024 next-gen update (Enclave Remnants) and the Nov 2025
Anniversary update. Anniversary adds at least one new deathclaw (Bessy, "Tale of the Beast Hunter").
Re-check strong-enemy coverage, and do all building/testing, on the current version.

**Strong-enemy variants (user checked):** Swan (DN131_LvlSMBehemothSwan, NPC_ 00056B7C) uses
SupermutantBehemothRace [RACE:000BB7D9]. Its NPC keyword list doesn't include ActorTypeSuperMutantBehemoth;
creature-type keywords usually sit on the race, so the keyword check should still work. The race is also on
GravLock_StrongRaces as a backup. Gatorclaws use the deathclaw race. Test both in-game.

**Version gap, newer Creations:** FEVer Dreams (Kinggath, free, Oct 20 2026) and Command Override (Hobgoblin,
Oct 2026). FEVer Dreams is an indoor escape-room dungeon; check after updating whether either adds strong
creatures, explosions or vehicles.

## Baseline results (2026-10-31, fresh current install, no mods, ~60 fps)

Ran from Vault 111 (northwest) to the southeast corner, rubbing against about two dozen cars.
- **Quincy-area Red Rocket: a car spawns overlapping a gas pump hose and rattles back and forth constantly.
  Rubbing against it for about a minute killed the player. Known, guaranteed repro.**
- Another known case (per the user): a truck north of Parsons State Insane Asylum. Check whether it's a pickup
  (in scope) or a box truck (out of scope).
- Small single-passenger car near the Lexington Super-Duper Mart moved when run into, but didn't kill.
- Several precarious spawns seen: cars falling from bridges and overpasses.
- About two dozen ordinary resting cars: no deaths.

**Conclusion:** the lethal case is a car that spawns **overlapping another object** and never stops moving
(physics keeps pushing the two apart). Resting cars are mostly harmless, but still pushable. Mods that add
collidable objects (grass, shrubs) can create new overlaps anywhere. Design change: rattle detection (lock a
car that keeps moving but stays in place after ~2 s), max settle time cut from 15 s to 8 s.

**Quincy repro details (second visit):**
- Car reference **001D9517**, overlapping hose reference **001F81D6**.
- First load: the car rattled, then shook itself loose, flipped onto its side, came to rest, and was harmless.
- Reload and run straight to it while still rattling: killed the player.
- So vanilla sometimes resolves the overlap on its own, but only after a lethal rattling window. With rattle
  detection the car locks ~2 s after loading, usually still overlapping the hose (visual clipping possible,
  but harmless). Accepted trade-off: safety over letting it shake loose.
- Only overlapping spawns seem to cause it. Scope stays automobiles: they're the heaviest common physics
  objects, and physics damage scales with mass; the user has only ever been killed by cars.
- **001D9517 = CarSportsCar07 [MSTT:001A3051]** (in scope). Placed as a *temporary* reference in cell
  0000E2A7 (Commonwealth, grid 4,-21). Position (20451.88, -85753.84, 1038.35), rotation (2.21, 359.81,
  181.86). Temporary refs reset with the cell, which is why the overlap repeats every time.
- User decision: visual clipping when a car locks overlapping something is fine (first-glance standard);
  the car must still move when it explodes (it does: explosions free it as usual).

The truck north of Parsons State Insane Asylum: **optional**, not needed (scope is decided by vehicle type).

**Second verified repro (user, 2026-11-01):** a truck southwest of Parsons Creamery, between the Creamery and
Lynn Woods, kills on touch in the base game. To check: is it a pickup (PickUpTruck01-11, in scope) or a box truck
(Truck01/02/03, out of scope)? Console: click it, note the ID; FO4Edit: NAME - Base. (Possibly the same truck
as the earlier "north of the asylum" report.)

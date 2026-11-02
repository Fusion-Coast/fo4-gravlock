# Prototype run 2 (2026-11-01 morning): Test B, own explosion

Spawned CarSportsCar07 (`player.placeatme 001A3051`), shot with a 10mm pistol (Weapon 00004822).

## User observations
- Spawned cars load slightly tilted every time and settle a little (normal for spawned cars; the real script's
  settling step covers this).
- Run 2: once the fire started, the car moved/settled; at the explosion it moved a full car length.
- Run 3: walked up to the burning car, it didn't move; at the explosion it moved a little.
- A separate run with a Molotov: hit arrived as a plain Weapon hit (Form 0010C3C6) again, no freeing.

## Log findings: the prototype update did NOT take effect
Both explosion runs show the car freed by its own small pop, ~5 s before the big explosion:

| Run 3 | Event |
|---|---|
| 08:23:00 | stage 0 -> 1 (burn starts) |
| 08:23:01 | hit by Explosion CarExplosion 00022496 (the car's own pop) |
| 08:23:01 | stages 1 -> 2 and 2 -> 3 (arrived out of order: 2->3 logged before 1->2) |
| 08:23:01 | **FREED (explosive hit)** |
| 08:23:06 | stage 3 -> 4 (big explosion) |

Expected with the update: CarExplosion ignored, "FREED (own explosion, stage 4)" at 08:23:06.
Likely cause: the new CarExplosion property left empty (or the script not recompiled).

So the timing question is still open: does a car that stays locked until the blast still get thrown?
The "didn't move while burning" result was luck (the car was already free).

## Other notes
- Stage-change events can arrive out of order (2->3 before 1->2). The real script uses `>= ExplodeStage`,
  so order doesn't matter.
- Spawned refs have FF-prefixed IDs (FF001617, FF00167E, FF001492...), as expected for placeatme.

## Next
Fill CarExplosion on both cars, confirm ExplodeStage 4 and a fresh .pex, repeat Test B.

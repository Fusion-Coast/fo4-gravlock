# Prototype run 6 (2026-11-01): Test D, strong enemies (behemoth) — acceptable

`tgm`, spawned CarSportsCar07, then a behemoth (`player.placeatme 0012B97E`).

| Time | Event |
|---|---|
| 09:19:23 | LOCKED (FF001592) |
| 09:20:44 | hit by Weapon 0014BBDA (behemoth's weapon), **aggressor = the behemoth** (FF0017AF), no projectile |
| 09:20:44 | hit by Explosion **BehemothSlamExplosion 00144AB3**, **aggressor None**, no projectile -> FREED |
| 09:21:27 | stage 0 -> 3 (rock damage) |
| 09:21:31 | stage 3 -> 4 (car's own explosion) |

User observations: the behemoth ran at the player and clipped through the edge of the car without moving it
(vanilla behavior). It swung and threw rocks; a swing made the car settle (freed); rocks caused the car to
explode; the car moved on the explosion. It never picked up or threw the car.

## Conclusions
- One swing produces two hits: the weapon hit (aggressor = behemoth) and the slam explosion (no aggressor).
  The real script catches both: IsStrongEnemy() via ActorTypeSuperMutantBehemoth on the attacker, and
  BehemothSlamExplosion on the approved explosion list. The explosion having no aggressor shows why the
  approved list is needed alongside the creature check.
- Rock hits weren't logged: the prototype stops listening after freeing. BehemothRockExplosion is on the
  approved list; the real script keeps listening, so confirm in full testing.
- Car throwing: not observed. Possibly rare or nonexistent in practice. Keep an eye out; not blocking.
- Deathclaw not tested (same logic: ActorTypeDeathclaw keyword + DeathclawRock/AOE explosions). Confirm in
  full testing.

## Still to run
- Test E: persistence (leave and return, save and load)

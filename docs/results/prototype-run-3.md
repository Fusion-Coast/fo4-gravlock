# Prototype run 3 (2026-11-01): Test B, own explosion — PASS

Fix from run 2 applied: CarExplosion property filled (it had been None), ExplodeStage 4.
Spawned CarSportsCar07 (`player.placeatme 001A3051`), shot with a 10mm pistol only.

| Time | Event |
|---|---|
| 08:46:11 | LOCKED (FF001918) |
| 08:46:20-24 | pistol hits (Weapon 00004822), stays locked |
| 08:46:24 | stage 0 -> 1 (burn starts) |
| 08:46:26 | stage 1 -> 2; hit by Explosion CarExplosion 00022496 (own pop) **ignored, stays locked** |
| 08:46:26 | stage 2 -> 3 |
| 08:46:31 | stage 3 -> 4 (big explosion) **FREED (own explosion, stage 4)** |

User observations: brushed against the burning car, no movement. After the explosion it moved
significantly, then settled.

## Conclusions
- **Timing answered (own explosion):** a car locked until the blast is still thrown by it. The script frees
  it in time; SelfExplosionImpulse stays 0 (backup not needed).
- The burning window (~5 s here) is safe: the car stays locked the whole time.
- Ignoring CarExplosion works.

## Still to run
- Test C: grenade and missile on a locked car (Weapon or Explosion? thrown?)
- Test D: behemoth / deathclaw hits and throwing
- Test E: persistence (leave and return, save and load)

# Prototype run 5 (2026-11-01): Test C retest, grenade — PASS

Updated prototype: explosive weapon hits with a projectile (contact) are ignored.

| Time | Event |
|---|---|
| 09:11:34 | LOCKED (FF001966) |
| 09:12:17 | hit by Weapon 000EEBED (frag grenade) **with projectile 000E574E** -> "explosive CONTACT ignored" |
| 09:12:19 | hit by Weapon 000EEBED **projectile None** (the blast) -> stage 0 -> 3 -> FREED (explosive hit) |
| 09:12:23 | stage 3 -> 4 (car's own explosion) |

User: grenade hit the car, car didn't move; the explosion moved it. Acceptable.

## Conclusions
- The blast arrives as its own hit, ~2 s after contact, with no projectile. The contact/blast rule works.
- Outside-explosion timing: answered for grenades and missiles. Cars are freed in time and thrown;
  ExplosionImpulse stays 0.
- Spawned and placed cars sometimes sit slightly clipped into the ground. Vanilla placement; the mod locks cars
  where the game puts them and doesn't change that. Out of scope (user decision).

## Still to run
- Test D: behemoth / deathclaw hits and throwing
- Test E: persistence (leave and return, save and load)

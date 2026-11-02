# Prototype run 4 (2026-11-01): Test C, outside explosions

Grenade arc via Demolition Expert ranks 1-2 (console). Spawned CarSportsCar07.

## Frag grenade
| Time | Event |
|---|---|
| 08:58:47 | hit by Weapon 000EEBED (frag grenade) **with projectile 000E574E** -> FREED |
| 08:58:49 | stage 0 -> 3 (grenade blast damage, ~2 s fuse later) |
| 08:58:53 | stage 3 -> 4 (car's own explosion) |

User: car shifted on the grenade's **impact** (undesirable: enemy grenades would do the same); shifted again on
the explosion (fine).

**Cause:** the prototype freed the car on the grenade's physical contact (bounce), 2 s before the blast; the
bouncing grenade then nudged the free car.

## Missile
| Time | Event |
|---|---|
| 08:59:34 | hit by Weapon 0003F6F8 (missile launcher) **no projectile**; stage 0 -> 3; FREED (same second) |
| 08:59:38 | stage 3 -> 4 |

User: shifted on impact ("so-so": a missile hits with extreme force) and on the explosion (desirable).
Missiles explode on contact, so impact = blast; the shift is the blast.

## Rule change
Blast hits arrive with **no projectile** (missile here; CarExplosion in runs 1-3). Contact hits carry the
projectile. Explosive weapons now only free a car on projectile-less hits. Applied to the prototype and the real
script. Open question: does the grenade's blast arrive as its own hit once the car stays locked through the
bounce? (Run 4 couldn't show it: the car was already free.)

## Next
Repeat the grenade test with the updated prototype: expect "explosive CONTACT ignored" on the bounce, no shift,
then "FREED (explosive hit)" at the blast.

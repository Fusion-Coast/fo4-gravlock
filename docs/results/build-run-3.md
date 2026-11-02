# Build run 3 (2026-11-01): Quincy, 30-car stress, persistence, behemoth

## Results
1. **Quincy Red Rocket car (the bug): PASS.** Stayed static, didn't move when rubbed against.
2. **30 cars spawned at once** (north of the Lexington Super-Duper Mart, toward Starlight Drive-In). While the
   spawned pile was still settling, a loose car killed the player (god mode used after that). Expected: 30 cars
   spawned on top of each other tumble for 10-20 s before they come to rest (log: locks at 10-20 s, all at
   02:05:46-57 when the pile reloaded). Real placed cars don't spawn in piles; they locked in 1-2 s.
3. **Persistence: PASS.** Fast travel away and walk back: all 30 cars loaded in, static, locked.
4. **Behemoth: PASS.** Rocks and weapon hits blew up cars; cars moved when they exploded, locked again once
   settled; walking past didn't move them; it never threw a car (fine).
5. Not run: the same 30-car test with the plugin disabled.

## Log findings
- Lock times overall: 213 at 1.0 s, 19 at 1.5 s, 21 at 2.0 s; the long ones (6-20 s) are the spawned pile.
- **No script overload:** no suspended stacks or stack dumps from our scripts with 30+ extra scripted cars
  loaded (all stack traces in the log are vanilla scripts).
- Behemoth: weapon hits (0014BBDA, aggressor = behemoth) freed cars; **BehemothSlamExplosion 00144AB3 and
  BehemothStompExplosion 0014D17C freed cars** (no aggressor; caught by the approved list).
- **A car's full blast (CarNukeLargeVehicles 00023D3B) DOES arrive as a hit on intact neighbors** and frees
  them (FF00326E, FF00328D, FF003391, FF003277). Confirms build run 2: only burnt-out (0 health) wrecks get no
  hit.
- Form 00083D0C arrives as a hit when a car explodes, with the aggressor set to whoever caused the explosion.
  Ignored when the player caused it; frees nearby cars when a behemoth caused it (aggressor = strong enemy).
  Harmless.
- Frag grenade contact (000E56C2 with projectile 000E56C3): ignored, as designed.

## Still open
- Concord deathclaw (the one guaranteed car throw, after rescuing Preston's group): does it still throw a
  locked car, and does the scene play normally?
- Optional: 30-car comparison with the plugin disabled.
- Molotov / cryo / pulse / explosive-legendary weapons on cars (covered by prototype + design; quick check).

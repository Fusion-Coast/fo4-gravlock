# Build run 1 (2026-11-01): first run of the full mod

Sanctuary Red Rocket. Spawned CarSportsCar07s, plus the parked cars there and a mini.

## Log
- **"GravLock: lists built: 11 explosive keywords, 5 non-moving keywords, 38 explosions, 2 strong keywords,
  1 strong races"**: all as expected (38 = Nuka-World installed). No MISSING lines.
- Cars find the config quest (their log lines only appear through it).
- ~50 placed cars locked as areas loaded, typically **1.0-2.0 s** after loading. Quincy car 001D9517 locked
  after 1.5 s.
- Leftover prototype errors ("Unable to re-create ... GravLock_ProtoLock") from the save made with the
  prototype. Harmless; they stop once the game is saved without it.

## Observations
1. Spawned car clipped into a hill. On exploding (stage 4, freed) it flew, spun ~10 s, bounced, landed in
   water. Log: **"locked after 8.000000 s"**, the max-settle backstop, while it was still moving. Then **stage
   5** ~50 s later freed it again, and it re-locked after 3 s.
2. Second spawned car: locked on spawn, stayed put under gunfire, freed at stage 4, moved a little, re-locked
   after 2.5 s. Good.
3. Parked Red Rocket cars: burned from gunfire, moved only when they exploded. Each freed at stage 4, re-locked
   ~2.5 s later, then **freed again at stage 5** and re-locked after 1 s.
4. Spawned car next to a mini: spawned car exploded and moved; the mini then exploded (its own stage 4) and
   moved a little. No "hit by" lines at all in the log, so we can't tell whether the neighbor's blast reached
   the mini as a hit.

## Fixes applied
- Free only when crossing INTO stage 4 (stage 5 no longer frees the car again).
- MaxSettleTime 8 s -> 20 s (rattle detection still locks stuck cars in ~2 s).
- Log every hit (freed or ignored) while DebugLogging is on, to see how a neighbor's blast arrives.

## Next test
Burnt-out car next to a car that explodes: does the blast arrive as a hit, and does it move the burnt-out car?

# Build run 2 (2026-11-01): neighbor blast vs a burnt-out car

Spawned car 1 (FF001579), exploded it, let it burn out. Spawned car 2 nearby and car 3 within 1-2 ft of car 1;
exploded both with pistol fire.

## Log
- Car 1: locked 1.5 s after spawn; own explosion (stage 4) freed it; **re-locked 2.0 s later** (so it was
  registered for hits).
- Cars 2 and 3: pistol hits all "ignored", own explosion (stage 4) freed each, re-locked 2.5-3 s later.
- **Car 1 received NO hit events when cars 2 and 3 exploded** (not even ignored ones). The only hits in the
  log are pistol shots.
- No stage-5 re-free seen (fix from run 1 holds, or the test ended before stage 5).

## User observation
Car 1 didn't move when either neighbor exploded. "I don't know if I care about this."

## Conclusion
A car's own blast (CarNukeLargeVehicles) doesn't arrive as a hit on a burnt-out (0 health) neighbor, so locked
burnt-out wrecks aren't moved by a neighbor's explosion. Intact neighbors still take damage, explode and move
(chain reactions work, build run 1). Recommended: accept as known behavior (fits "only forced movement";
alternatives would need exploding cars to search for and push neighbors, reintroducing risk). **User decision: accepted.** "I only care that they don't kill me when I brush against them"; where a wreck
lands after exploding isn't worth chasing.

# Test plan

Every release candidate passes all of these on PC first, then Xbox (and PlayStation if a build exists).
Record each run with the "Test run" issue template.

## Contact (car must NOT move)
- [ ] Walk into the car from each side
- [ ] Sprint into the car
- [ ] Jump onto / off the car
- [ ] Melee and bayonet strikes
- [ ] In power armor
- [ ] Companion or NPC pathing into the car

## The known repro (must pass)
- [x] Quincy-area Red Rocket car (overlapping the gas pump hose): still on arrival, never moves, never kills
      (build run 3)
- [ ] Truck north of Parsons State Insane Asylum (if in scope): same

## Settling (car MUST fall, then lock)
- [ ] Car that loads in a tree falls (or stays put if physics leaves it there), then locks
- [ ] Car that loads hanging off an overpass falls, then locks where it lands
- [ ] After landing, walking into it doesn't move it
- [ ] Car already at rest locks within about a second of loading (no visible wobble)
- [ ] Rattling car (stuck against another object) locks within about 2 seconds of loading
- [ ] Car tumbling down a slope isn't mistaken for rattling: it lands, then locks
- [ ] Player standing next to a settling car isn't killed (watch the settle window closely)

## Gunfire
- [ ] Small arms before any destruction stage: car doesn't move
- [ ] Sustained fire until the car burns: unlocks at the expected stage

## Explosions (car MUST move)
- [x] Grenade / mine next to an intact car (build run 4: contact ignored, blast frees)
- [ ] Car's own explosion flips or throws it
- [ ] Burning car (warning icon up): walking into it doesn't move it
- [ ] Standing right next to a car when it explodes: car moves as in vanilla (random direction)
- [ ] Mini-nuke / Fat Man
- [ ] Chain reaction across several cars
- [ ] After an explosion, the car re-locks where it lands and can't be pushed
- [x] Burnt-out car hit by a grenade: moves, lands, re-locks (build run 4)
- [ ] Burnt-out car hit by a mine, missile, and Fat Man: same
- [x] Burnt-out car next to another car that explodes: stays put (accepted known behavior, build run 2)
- [x] Intact car next to another car that explodes: chain reaction, explodes and moves (build run 1)
- [ ] Car next to another car's small stage-1 pop: doesn't move
- [ ] Sentry bot self-destruct next to a car: moves it
- [ ] Gas canister, oxygen tank, fuel barrel, fusion core meltdown, vertibird crash next to a car: car catches
      fire but isn't pushed; moves only when it explodes
- [ ] Minutemen artillery, Constitution cannon, rocket and cannon traps: car doesn't move
- [ ] Explosive-legendary shotgun / rifle / pistol on a burnt-out car: doesn't move
- [ ] Explosive-legendary shotgun / rifle on an intact car: doesn't move until the car's own destruction stages trigger
- [ ] Legendary missile launcher / grenade / Fat Man: moves the car
- [x] Molotov on an intact car: no push on hit; the fire burns it, and it moves when it explodes (build run 4)
- [ ] Cryo and pulse grenades and mines on a car: no push
- [ ] Broadsider cannonball: moves the car
- [ ] Enemy explosives (suicider mini nuke, raider grenades, Gunner missiles): move the car
- [ ] Deathclaw hit: moves the car, which re-locks where it lands
- [x] Behemoth hit: moves the car, which re-locks where it lands (build run 3)
- [ ] Deathclaw / behemoth running into a car: doesn't move it
- [ ] Behemoth / deathclaw picks up and throws a locked car: still works? Car re-locks after landing?
- [ ] After any freed car lands mid-battle, brushing past it doesn't move it
- [ ] Every variant: Deathclaw, Young, Alpha, Glowing, Chameleon, Savage, Matriarch,
      Albino (Far Harbor), Gatorclaw (Nuka-World), Quantum (Nuka-World), legendary versions, Behemoth, Swan,
      legendary behemoth
- [ ] Regular super mutant, raider, or other melee: doesn't move the car
- [ ] Burnt-out car shot with normal guns or hit with melee: doesn't move

## Enemies
- [ ] Concord deathclaw (after rescuing Preston's group; the one guaranteed car throw): still throws a locked
      car? Does the scene play normally? **Deferred to a normal playthrough; not blocking release.** The mod
      doesn't touch animations, the deathclaw or the quest; worst case the deathclaw uses another attack.
- [ ] Check whether any vanilla enemy throws or grabs cars (behemoth, deathclaw, others)
- [ ] If so, the throw still works

## Persistence
- [x] Leave the area and return: intact cars still locked, destroyed cars stay where they landed (build run 3)
- [ ] Save and load, both near the car and far from it
- [ ] Fast travel in and out

## Out of scope (must behave exactly like vanilla)
- [ ] Buses, large trucks, heavy equipment, rail vehicles: no script attached, vanilla behavior
- [ ] Set-piece vehicles (e.g. trucks wedged in quest locations) are undisturbed

## Settlements and compatibility
- [ ] Workshop: scrap, store, and move cars
- [ ] With Unofficial Fallout 4 Patch
- [ ] FO4Edit conflict check against popular mods that touch car records

## Performance
Stress test instead of a heavy city area (works on older hardware too):
- [ ] At a location that runs well (Sanctuary, Red Rocket), spawn a crowd: `player.placeatme 00194634 30`
      (repeat to add more). Note frame rate and stutter
- [ ] Same spawn with the plugin disabled: compare
- [x] Papyrus log: no "stack dump" or "suspended stack" warnings with 30+ extra cars (build run 3)
- [ ] Record the car count where any difference appears

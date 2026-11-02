# Grav Lock (fo4-gravlock)

A Fallout 4 plugin that gives cars correct gravity and prevents accidental death: wrecked cars stop killing the player on contact.

## Credits and AI disclosure

Design, research and testing by **Fusion Coast**. Scripts and documentation written with AI assistance, then
verified through in-game testing and Papyrus logs (see `docs/results/`). Tagged "AI-Generated Content" on Nexus.

## The bug

Brushing against a static car wreck can nudge it a few pixels. The physics engine then snaps it back into the
space the player occupies, and the overlap kills the player instantly. Bayonets and melee can trigger the same thing.

## Scope

Only **automobiles**: cars, pickup trucks and Vault-Tec vans (64 base-game records; see
`docs/research/car-records.md`). Motorcycles may be added later (the "Automobiles and motorcycles" class on the
[Fallout Wiki vehicle list](https://fallout.fandom.com/wiki/Fallout_4_vehicles)). Buses, large box trucks, heavy
equipment and rail vehicles are often set pieces and aren't a factor in the bug, so this mod leaves them
completely untouched: they behave exactly as in vanilla.

## The fix

**Settle, then lock.** When a car loads, it keeps normal physics just long enough to come to rest. Once its
position and angle stop changing, it becomes **keyframed**: solid, but nothing can push it. Cars that load in a
precarious spot (in a tree, hanging off an overpass) fall naturally first and lock where they land. Cars already
sitting still lock within about half a second.

**Only explosions and the strongest enemies can move a locked car.** The goal is to raise the force needed to
move a car above anything the player can produce by touch. Three things unlock a car:

- its own explosion (the moment it blows, not earlier: a burning car with the warning icon stays locked)
- an approved explosion hitting it (grenade, mine, missile, Fat Man, a robot self-destructing), even if the car
  is already burnt out
- a hit from a deathclaw or super mutant behemoth (including their slam, stomp and thrown-rock attacks)

"Deathclaw" and "behemoth" means every variant: alpha, glowing, chameleon, savage, matriarch, gatorclaw,
legendary, DLC versions, and named ones like Swan.

After any of these, the car moves under normal physics, then **re-locks wherever it comes to rest**, so a car
blasted across the street mid-battle can't kill you when you brush past it afterward.

Known behavior (accepted): a neighboring car's explosion doesn't move a burnt-out wreck, because the game doesn't
report that blast as a hit on a car with no health left. Intact neighbors still catch fire, explode and move, so
chain reactions work. The goal is that cars can't kill you on contact; where a wreck ends up is secondary. A burnt-out car
can't explode on its own again, so it stays locked until another explosion hits it.

| Situation | Car moves? |
|---|---|
| Player walks, sprints, or bumps into it | No |
| Melee / bayonet hits | No |
| Gunfire, including explosive-legendary guns (explosive shotgun, rifle) | No, until it triggers the car's own destruction |
| Deathclaw or behemoth (any variant) hitting it | Yes, then re-locks where it lands |
| Deathclaw or behemoth running into it | No (not a vanilla mechanic either) |
| Any other non-explosive force | No |
| Explosive weapons (grenade, mine, missile, Fat Man, Nuka/plasma/bottlecap explosives, Broadsider), legendary or not | Yes, then re-locks where it lands |
| Molotov, cryo and pulse grenades and mines | No on hit. Their damage still counts: a Molotov fire can burn a car until it explodes |
| Gas canisters, oxygen tanks, fuel barrels, fusion core meltdowns, crashing vertibirds | No on hit. They set cars on fire, and the car moves when it explodes |
| Artillery, Constitution cannon, rocket and cannon traps | No |
| Robot self-destruct (sentry bots etc.) | Yes, then re-locks where it lands |
| Loaded mid-air or in a precarious spot | Yes, falls naturally, then locks where it lands |
| Car is burning (warning icon showing) | No |
| Car explodes, even with the player right next to it | Yes, in whatever direction the blast sends it, then re-locks |
| Burnt-out car hit by a grenade, missile, etc. | Yes, then re-locks where it lands |
| Burnt-out car next to another car that explodes | No (game doesn't report that blast as a hit; accepted) |
| Intact car next to another car that explodes | It catches fire, explodes, and moves (chain reaction) |

Note: this needs a script, which Sony doesn't allow in new PlayStation mods. A PlayStation build is still unproven.

Achievements: hand-installed plugins disable them. Consider releasing through the Verified Creator Program
(even for free) so the Creation can be marked as not disabling achievements.

## Status

**Prototype complete: all five tests passed** (`docs/results/prototype-run-7.md` has the summary). The Quincy
Red Rocket car, which reliably killed the player, stays locked and harmless; cars still explode and get thrown
normally; grenades, missiles and behemoths behave as designed.

**Full mod built and tested** (`docs/results/build-run-1..4.md`): the Quincy car stays locked, cars explode and
get thrown normally, grenades/Molotovs/behemoths/deathclaws behave as designed, no script overload with 30+
extra cars. **Next: release prep** (`docs/release.md`).

## Distribution

**Plan (updated 2026-11-01):**
1. **Nexus Mods first** (PC: Steam and GOG). A published, working mod is needed as proof for the Verified
   Creator Program application.
2. Optionally a **free Creation** at the same time (anyone can post free Creations; reaches Xbox and the in-game
   menu).
3. **Apply to the Verified Creator Program** with the published mod.
4. Later, a Verified Creation release, for the achievement-friendly option if available.

No F4SE. Switch 2 can't be modded.

| Build | Contents | Status |
|---|---|---|
| PC (Nexus, Creations) | `FO4GravLock.esp` (light plugin) + compiled scripts | Release candidate 1.0.0 |
| Xbox (Creations) | Same files; uploaded from the Creation Kit on PC (Steam-linked Bethesda.net account, no Xbox account needed). Needs an Xbox tester | Later |
| PlayStation | Not feasible: Sony bans new scripts in mods | Not planned |

## Repo layout

```
Data/
  (FO4GravLock.esp: the plugin; distributed in the release ZIP, not tracked here)
  Scripts/Source/User/           Papyrus source: GravLock_ConfigScript (quest), GravLock_CarLockScript (vehicles)
prototype/                       the prototype script (kept for reference)
tools/                           FO4Edit script that attaches the car script to all 64 vehicles
docs/
  research/                      findings: car records, meshes, destruction data
  build.md                       step-by-step build guide
  release.md                     release steps: logging off, light plugin, packaging, compatibility
  nexus-page.md                  Nexus mod page draft (BBCode)
  prototype.md                   the prototype plan (done)
  results/                       prototype and test results
  testing.md                     pass/fail test plan
.github/ISSUE_TEMPLATE/          test-run and bug report templates
```

Compiled scripts (`.pex`) and archives (`.ba2`) are build outputs, so they're not tracked. Build them in the Creation Kit.

## Tools

Creation Kit (Steam), FO4Edit, NifSkope (dev build), VS Code + Papyrus extension, Mod Organizer 2 or Vortex.

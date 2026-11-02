# Nexus page draft: Grav Lock

Fill in the bracketed bits. The description is BBCode, ready to paste into Nexus's description editor.

---

## Page fields

**Mod name:** Grav Lock - No More Car Deaths

**Version:** 1.0.0

**Category:** Bug Fixes

**Brief overview** (Nexus limit ~350 characters):
> Parked cars can no longer kill you when you brush against them. Cars stay locked in place until something with
> real force moves them (their own explosion, grenades, missiles, behemoths, deathclaws), then lock again where
> they land. No F4SE, no requirements, light plugin.

**Tags to add:** Bug Fixes, Immersion, Gameplay, **AI-Generated Content** (required: the scripts were written with
AI; see Credits)

**Requirements:** none (Fallout 4 only; DLC optional)

**Main file:** `FO4GravLock-1.0.0.zip`, description: "Grav Lock 1.0.0: plugin, scripts and script source."

**Images:** before/after of the Quincy Red Rocket car (it rattles against the gas pump hose and kills on contact
in the base game), plus a car flipping from its own explosion to show explosions still work.

---

## Description (BBCode), in Nexus's template order

```
[size=4][b]1. Description[/b][/size]
[i]Parked cars can't kill you anymore, because they can't move into you. They still blow up like they always did.[/i]

Since 2015, walking or sprinting past a parked car has had a small chance of killing you instantly. The cause: some cars spawn slightly overlapping another object (a gas pump hose, a fence, scenery added by mods), and the physics engine rattles them back and forth forever. Touch a rattling car and it hits you like a train. Bethesda never fixed it.

Two verified examples:
[list]
[*][b]The car at the Red Rocket near Quincy[/b], wedged against a gas pump hose. In the base game, rubbing against it kills you. With Grav Lock, it just sits there.
[*][b]The truck southwest of Parsons Creamery[/b], between the Creamery and Lynn Woods. In the base game, it kills on touch too. [CONFIRM: with Grav Lock, it just sits there]
[/list]

Grav Lock fixes the cause rather than the symptom: cars are locked in place until something with real force moves them, then they lock again where they land. Everything else about cars, explosions and physics damage stays vanilla.

[b]How it compares to other fixes[/b]
[list]
[*][b]Car Physics Death Bug Fix (opt33)[/b] lowers physics damage so the glitch only takes 30-60 HP. Cars still rattle and get launched.
[*][b]LarannKiar's physics damage mod[/b] switches off all physics damage everywhere. Requires F4SE (PC only).
[*][b]Grav Lock[/b] stops the movement itself, so the glitch can't happen, while every other kind of physics damage stays vanilla. No F4SE.
[/list]
Both are good mods with a different approach; you don't need them alongside this one.

[size=4][b]2. Installation instructions[/b][/size]
[list]
[*][b]Mod manager[/b] (Vortex, MO2): install and enable as usual.
[*][b]Manual:[/b] extract the archive into your [i]Fallout 4\Data[/i] folder so that [i]FO4GravLock.esp[/i] is in Data and the two .pex scripts are in [i]Data\Scripts[/i]. Then enable FO4GravLock.esp in your load order.
[/list]
[list]
[*]It's a [b]light plugin (ESL-flagged)[/b], so it doesn't use one of your regular plugin slots.
[*][b]Safe to install mid-playthrough.[/b]
[*][b]Load order:[/b] place it after the Unofficial Fallout 4 Patch and after any mod that changes vehicles.
[*][b]Uninstalling:[/b] disable the plugin and delete its files. Cars go back to vanilla behavior (rattling included). Your Papyrus log may show a few harmless "missing script" lines for that save afterward; they stop once you save without the mod.
[/list]

[size=4][b]3. Main features[/b][/size]
[list]
[*][b]Cars are locked in place.[/b] Solid, but nothing you do by touch can push them: walking, sprinting, jumping on them, melee, bayonets, gunfire. In or out of power armor.
[*][b]Rattling cars are caught.[/b] A car stuck shaking against something locks within about 2 seconds of loading, usually before you can even see it.
[*][b]Cars that load in mid-air still fall[/b] (off bridges, out of trees), then lock where they land.
[*][b]Explosions still work.[/b] A car stays locked while it burns (so it can't get you while you run) and is freed the instant it explodes, so the blast flips or throws it like vanilla.
[*][b]Real force still moves cars:[/b] grenades, mines, missiles, Fat Man (and the Striker), the Broadsider, robots self-destructing, and hits from deathclaws and behemoths (every variant). Afterward the car locks again wherever it lands, so a car thrown across the street mid-battle can't kill you later.
[*][b]Completely silent:[/b] no messages, menus or settings.
[/list]

[b]What does NOT move a car[/b]
[list]
[*]Gunfire, including explosive-legendary guns (explosive shotgun, rifle)
[*]Molotovs, cryo and pulse grenades/mines (they still damage cars: a Molotov fire can burn a car until it explodes)
[*]Gas tanks, fuel barrels, fusion core meltdowns, crashing vertibirds (they set cars on fire; the car moves when it explodes)
[*]Artillery, the Constitution's cannon, rocket and cannon traps
[/list]

[b]Which vehicles[/b]
All 64 "explodable car" vehicles in the base game: every car (mini, sedan, sports car, Fusion Flea, coupe, station wagon), every pickup truck and every Vault-Tec van. Buses, box trucks, heavy equipment and rail vehicles stay exactly vanilla: they're mostly set pieces and aren't part of the bug.

[b]Known behavior[/b]
[list]
[*][b]Burnt-out wrecks stay where they are[/b] when a neighbouring car explodes (the game doesn't report that blast to a car with no health left). Intact cars nearby still catch fire and explode: chain reactions work.
[*][b]Cars spawned in a pile[/b] (e.g. with console commands) tumble over each other for a while before they settle and lock. Cars placed by the game never start in piles.
[*][b]Creatures throwing cars:[/b] not observed during testing. If a deathclaw or behemoth can't pick up a locked car, it simply uses another attack.
[*]Vehicles clipped into the ground or scenery stay where the game placed them; the mod doesn't move placements.
[/list]

[b]How it was tested[/b]
A 5-test prototype, 4 full test sessions and a release-candidate package test: the Quincy car, every explosive type, behemoths, deathclaws, persistence across travel and saves, and a 30-car stress test with no script load issues. Full logs and results are on GitHub (see Shout outs).

[size=4][b]4. Requirements[/b][/size]
[list]
[*]Fallout 4, current version (built and tested on the [current Steam version, Anniversary Edition update])
[*][b]No F4SE, no other mods.[/b]
[*]DLC optional. With Nuka-World installed, its explosives (Nuka-Cherry/Quantum grenades, Nuka-nuke, Nukatrons...) are recognized automatically.
[*][b]Compatible with the Unofficial Fallout 4 Patch[/b] (checked in FO4Edit: no shared records).
[*]Conflicts only with mods that edit the same 64 vehicle records. Mods that add their own cars aren't covered; their cars behave as their author made them.
[/list]

[size=4][b]5. Shout outs[/b][/size]
A huge thank-you to [b]Bethesda's Fallout 4 developers[/b] for building a world people are still exploring and reshaping ten years on, and for releasing the tools to do it. And to [b]Fallout 4's modders[/b]: making this taught me how much careful, unglamorous work goes into even a small fix. The research, the testing, the tools, and the generosity of the people who document it all. You've earned a lot of respect from me. Special thanks to the [b]xEdit team[/b] for FO4Edit, which this mod leans on heavily, and to opt33 and LarannKiar for tackling this bug before me.

[b]Credits and transparency[/b]
[list]
[*][b]Design, research and testing:[/b] Fusion Coast
[*][b]Scripts:[/b] written with AI assistance (hence the AI-Generated Content tag), then verified through in-game testing and Papyrus logs
[*][b]Source code and development notes:[/b] both scripts (source included in the download), the research, the test plan and every test result: [url=https://github.com/Fusion-Coast/fo4-gravlock]github.com/Fusion-Coast/fo4-gravlock[/url]
[*]Bug reports welcome here or as a GitHub issue.
[/list]
```

---

## Permissions (Nexus "Permissions and credits" tab) — suggestion

- Upload to other sites: ask first (keeps it under your name)
- Modify / build on: yes, with credit (it's open source anyway)
- Convert to other games: n/a
- Assets/scripts in other mods: yes, with credit
- Donation points: your choice

## Before publishing
- [ ] Replace the bracketed game version text
- [ ] Parsons Creamery truck: confirm it's a pickup (in scope, fixed) and test it with Grav Lock, then remove the
      [CONFIRM] note. If it's a box truck (Truck01/02/03), Grav Lock doesn't cover it: reword or remove that example
- [ ] Make the GitHub repo public (or remove the link)
- [ ] Re-check `docs/prior-art.md` for new competing mods
- [ ] Screenshots

# Car records

**Record type: Moveable Static (MSTT).** Found in FO4Edit by filtering Editor IDs for `car`,
with Fallout4.esm + all DLC + a set of common mods loaded (2026-10-31).

## Everything with the ExplodableCar keyword (KYWD:0021C00D)

From FO4Edit "Referenced By" on ExplodableCar: **77 references = 76 MSTT vehicles + 1 default object**
(`ExplodableCar_DO` [DFOB:0021C00E], probably what the game uses to find cars for the about-to-explode
warning icon). All 76 are in Fallout4.esm; no DLC adds explodable cars. No motorcycles, buses or semis.

| Group | Count | Editor IDs | Form IDs | In scope? |
|---|---|---|---|---|
| Cars | 48 | see table below | | Yes |
| Pickup trucks | 11 | PickUpTruck01 to PickUpTruck11 ("Truck") | 001B8A9B to 001B8AA5 | Yes |
| Vault-Tec vans | 5 | VaultTecVan01, VaultTecVan02, VaultTecVan01Prewar, VaultTecVan01Blue, VaultTecVan02Blue ("Van") | 00081107, 000821CC, 000E6CC2, 00204812, 00204813 | **Yes** (confirmed) |
| "Truck" | 12 | Truck01/02/03 x White/Blue/Red/Green | Truck01White 0009F947, Truck02White 000A847D, Truck03White 000A847E, Truck01-03Blue 000A847F-000A8481, Truck01-03Red 000A8482-000A8484, Truck01-03Green 000A8485-000A8487 | **No: large box trucks** (see below) |

**In scope: 64 records** (48 cars + 11 pickups + 5 vans). Out of scope: the 12 box trucks.

### Truck01White (0009F947): why the "Truck" records are out of scope
- Model `Vehicles\Automotive\Truck01.nif`, hulk `Truck01Hulk.nif`
- Object bounds (-303,-155,-2) to (340,155,241): 643 x 310 x **243** units, about twice a sedan's height
  (sedan: 553 x 263 x 118)
- Health **1200** (sedan 500)
- Keywords: ExplodableCar only, **no CanBeThrown**: vanilla doesn't let creatures throw it
- No Obstacle record flag (sedan has Obstacle)
- Destruction: 98% burn starts (2/s), 85% CarExplosion pop (8/s), 75% (24/s), **50% CarNukeLargeVehicles
  with Destroy flag at stage index 3** (same as the sedan), 0% final
- Decision: large truck, leave vanilla (user rule: large trucks and buses are set pieces)

### Vault-Tec vans
In scope (user confirmed). Far Harbor uses vans as enemy homes: check which records those are (base-game
vans placed in DLCCoast, or separate statics). Settling doesn't wake a resting vehicle, so placed set-piece
vans stay where they are.

## Fallout4.esm: cars (in scope)

| Model | Editor IDs | Form IDs |
|---|---|---|
| Mini | CarMini01Prewar, CarMini01 | 00188D18, 00188D20 |
| Sedan | CarSedan01 to CarSedan11 | 00194634 to 0019463E (not in numeric order: 634=01, 635=04, 636=07, 637=10, 638=02, 639=03, 63A=05, 63B=06, 63C=08, 63D=09, 63E=11) |
| Sports car | CarSportsCar01 to CarSportsCar11 | 001A304B to 001A3055 |
| Fusion Flea | CarFusionFlea01Clean, CarFusionFlea01 | 001A6395, 001A6602 |
| Coupe | CarCoupe01 to CarCoupe11 | 001B2DB3 to 001B2DBD |
| Station wagon | CarStationWagon01 to CarStationWagon11 | 001B8AA6 to 001B8AB0 |

48 records so far. The in-game name is "Car" for all of them.

## Also matched "car", probably not in scope

| Editor ID | Form ID | Notes |
|---|---|---|
| EngineCarDestructible | 00047F7B | Named "Engine". Check what this is (a separate engine piece?) |
| AutomotiveCar02Debris01-03 ... Car05Debris01-03 | 000822D7-000896FD | Debris pieces, probably spawned by explosions. Leave vanilla. |
| ShoppingCart01, BabyCarriage01, Cardboard_Box..., etc. | | Not vehicles |

## CarSedan01 (00194634): full record

- **Record flags:** Obstacle, NavMesh Generation - Bounding Box
- **Model:** `Vehicles\Automotive\Sedan01_Postwar.nif`
- **VMAD (scripts):** field present but empty, so MSTT records CAN hold scripts
- **Keywords:** `CanBeThrown` [KYWD:000329F0], `ExplodableCar` [KYWD:0021C00D]
  - CanBeThrown: the vanilla system that lets creatures pick up and throw the car
  - ExplodableCar: possible ready-made tag to find cars, instead of adding our own keyword
- **Overrides:** none of the loaded mods (including the Unofficial Patch) change this record
- **Destructible:** Health 500, 5 stages

| Stage index | Health % | Model stage | Self damage/sec | Explosion | Notes |
|---|---|---|---|---|---|
| 0 | 80 | 1 | 8 | none | Burn starts (debris count 1) |
| 1 | 75 | 2 | 32 | CarExplosion [EXPL:00022496] | Small pop, burns faster |
| 2 | 70 | 3 | 20 | none | |
| 3 | 50 | 4 | 5 | CarNukeLargeVehicles [EXPL:00023D3B] | **The big explosion.** Destroy flag, debris 10, sequence "stage2", model swaps to `Sedan01_PostwarHulk.nif` |
| 4 | 0 | 5 | 0 | none | Final |

Burn time from 80% to the explosion at 50% (500 health): 80%->75% is 25 HP at 8/s (~3.1 s), 75%->70% is
25 HP at 32/s (~0.8 s), 70%->50% is 100 HP at 20/s (5 s). Total about **9 seconds** of burning if nothing
else damages it.

**ExplodeStage = 3** (DSTD index). Open question: does Papyrus number stages the same way as the DSTD index,
or is it off by one (0 = undamaged)? Test in-game with a debug notification before trusting it.

## Still to find
- Motorcycles: **deferred** (user may add later). Not on the ExplodableCar list; check whether they explode at all
- Do all 64 in-scope vehicles put the big explosion at stage index 3? (Spot-check a pickup, a van, and one
  of each car model)
- Far Harbor van homes: which records, and do they behave differently?
- ~~Which other records carry ExplodableCar?~~ Done above. Which carry CanBeThrown?
- DLC automobiles: none have ExplodableCar. Check whether DLC places base-game cars or non-explodable ones
- Whether MSTT records can hold scripts and keywords (check a record's fields)
- Destruction stages on each car: which stage is burning, which is the explosion
- Which of these records the Unofficial Patch or other mods change

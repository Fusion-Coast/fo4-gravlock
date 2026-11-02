# Explosions that can move a car

Approach: **approved list only** (`GravLock_MovingExplosions`). Fallout4.esm has well over 200 Explosion
records, most of them harmless (light-bulb sparks, gore, teleport effects, animal deaths). Any explosion not on
this list never moves a car. Source: FO4Edit, Explosion records whose Editor ID contains "explosion"
(2026-10-31, an older pre-2024 game build). DLC explosions are not checked yet.

## Approved

### Explosive weapons (player and enemy)
| Editor ID | Form ID |
|---|---|
| fragGrenadeExplosion | 000E574F |
| fragGrenadeChildExplosion | 001A43EF |
| nukaGrenadeExplosion | 000E5752 |
| plasmaGrenadeExplosion | 0017B3B2 |
| BaseballGrenadeExplosion | 00245F21 |
| fragMineExplosion | 000EECE9 |
| MS16fragMineExplosion | 00123F1A |
| BottleCapMineExplosion | 0023D535 |
| TrapfragGrenadeExplosion2 / 3 | 001C037C / 001C037B |
| ExplosionMissileShell | 000FD3AA |
| ExplosionMissileShellSmallSentry | 00216359 |
| SentryShoulderClusterExplosionChild | 00216362 |
| FatManExplosion | 001A7FF2 |
| FatManExplosionMIRVpack / MIRVchild | 001C6BFF / 00246741 |
| ExplosionBroadsiderBase | 00118615 |
| ExplosionGrenadeShell | 0001F8C5 (check what fires this) |

### Big blasts in the world (user approved)
| Editor ID | Form ID |
|---|---|
| CarNukeLargeVehicles (another car's full blast) | 00023D3B | (kept, but build run 2 showed it doesn't arrive as a hit on burnt-out neighbors; accepted) |
| robotSelfDestructExplosion / Large / Small | 001A673A / 001AF074 / 001AF075 |

### Strong-enemy attacks
| Editor ID | Form ID |
|---|---|
| BehemothSlamExplosion | 00144AB3 |
| BehemothStompExplosion | 0014D17C |
| BehemothRockExplosion | 0014BBDC |
| SwanSupermutantAmbushExplosion01 | 00156D08 |
| DeathclawRockExplosion | 00121AC2 |
| DeathclawAOEAttackExplosion | 00043365 |

## DLC explosions

Load-order prefixes below are from the user's setup (01 DLCRobot, 03 DLCCoast, 06 DLCNukaWorld); in the plugin
they'll be looked up by file at runtime so the DLC stays optional.

### Approved (move cars)
| File | Editor ID | Form ID | Why |
|---|---|---|---|
| DLCNukaWorld | DLC04_FragGrenadeMIRVExplosionPack / MIRVExplosion | xx033902 / xx033904 | Frag MIRV grenade |
| DLCNukaWorld | DLC04NukaCherryGrenadeExplosion | xx040CDF | Nuka grenade variant |
| DLCNukaWorld | DLC04NukaQuantumGrenadeExplosion | xx040CE1 | Nuka grenade variant |
| DLCNukaWorld | DLC04RaiderOverboss_FragGrenadeSingleExplosion | xx04A61B | Frag grenade |
| DLCNukaWorld | DLC04SentryShoulderClusterExplosionChild | xx0213A9 | Sentry bot missiles (same as base game) |
| DLCNukaWorld | DLC04SentryShoulderCherryExplosion | xx0505EA | Sentry bot missiles, Nuka-Cherry variant |
| DLCNukaWorld | DLC04NukaNukeExplosion | xx019418 | Mini-nuke variant (user confirmed) |
| DLCNukaWorld | DLC04NukatronCherryExplosion / QuantumExplosion / ColaExplosion | xx032F5A / xx032F5B / xx0439F8 | Robot self-destruct (user confirmed) |

### Not approved (no push on hit)
- **DLCRobot:** TrackSystem_TrapMine (part of the Mechanist's lair track trap system, not used by roving robot
  gangs; user rule: yes only if roving gangs use it), ChainLightning, pulseGrenadeExplosionMechanist (pulse), LightningHazard, SmokeBomb(s),
  Unstable_SentryExplosiveMinigunExplosion (explosive bullets), Unstable_SentryFrenzyGas, FakeForce100
- **DLCCoast:** VRDataRetriever, SubBase explosions (scripted quest event), HermitCrabSpawn, Paintball
  projectiles, FogCrawlerAOE / HermitCrabAOE (not strong enemies), FogCrawlerDeath, caltrop and bear traps
- **DLCworkshop01 (Wasteland Workshop):** sawblade trap
- **DLCworkshop02 (Contraptions):** fireworks, Junk Mortar primary/secondary (like artillery)
- **DLCworkshop03 (Vault-Tec):** Stagger, SuperReactor, E01
- **DLCNukaWorld:** Raider Overboss discharges, MisterStream, IntimidateGrenade, fireworks, PackScentGrenade,
  DisciplesFrenzyGrenade, NukaColaMister, Thirst Zapper (all), AcidSoaker, LuckyRabbitsFoot, Oswald teleport,
  Paddleball (all), BloatedBrahmin, TrapFakeForce

## Deliberately NOT on the list (no push on hit)

Their damage still counts: anything that sets a car on fire burns it toward its own explosion, which frees
it.
| Editor ID | Form ID | Why |
|---|---|---|
| ExplosionMolotovCocktail | 001D412E | Fire, not blast (fire still burns the car toward its own explosion) |
| cryoGrenadeExplosion / cryoMineExplosion / ExplosionCryoProjectile | 0017A57F / 0017B3B3 / 00230F89 | Cryo |
| pulseGrenadeExplosion | 0015B07E | Pulse (pulse mine explosion not found yet) |
| mod_Legendary_ExplosiveProjectileExplosion | 001E73BB | Explosive legendary bullets |
| ExplosiveProjectileExplosion | 001B5EDC | Probably also explosive bullets: check |
| mod_Legendary_Stagger* | 001E81A5-A7 | Legendary stagger effect |
| CarExplosion | 00022496 | The small "pop" at a car's stage 1, not the big blast |
| ExplosionGasCanister | 001FF24D | Like a Molotov: sets cars on fire, no push (user decision) |
| OxygenTankExplosion / VaultOxygenTankExplosion | 0005A674 / 000D76E8 | Like a Molotov (user decision) |
| BarrelTankExplosion / 02 / 02Vert | 000A4C97 / 0022DBAE / 00237F98 | Like a Molotov (user decision) |
| ExplosionFusionCoreMeltdown / KnightMeltdown | 00180A45 / 000865EE | Like a Molotov (user decision) |
| VertibirdDeathExplosion | 00020023 | Like a Molotov: crashing vertibird sets cars on fire, no push (user decision) |
| MinArtilleryExplosion | 000AE812 | Minutemen artillery: no push (user decision) |
| MS11CannonExplosion | 0017AE20 | USS Constitution cannon: no push (user decision) |
| DN029CannonLauncherExplosion | 000CA0B3 | Cannon trap: no push (user decision) |
| POIRocketExplosion | 0023E582 | Rocket trap: no push (user decision) |
| FakeForce* | various | Scripted quest pushes |

## Still to check
- ~~DLC explosions~~ Done above (all decided)
- Explosions whose Editor ID doesn't contain "explosion" (CarNukeLargeVehicles was one): skim the full
  Explosion category
- Nuka mine and plasma mine explosions (may reuse the grenade explosions)
- ~~The Striker~~ **Covered, no special handling.** It isn't its own weapon record: it's a legendary mod
  (`DLC03_mod_Custom_Weapon_Striker` [OMOD:xx056F2A], attach point ap_Legendary) on a regular Fat Man, handed
  out through `DLC03_CustomItem_DoNotPlaceDirectly_TheStriker` [LVLI:xx031702] with mod list
  `DLC03_CustomItemMods_TheStriker` [FLST:xx031700]. The mod adds value x4, the cripple enchantment
  (DLC03_ench_mod_CustomWeapon_Striker [ENCH:xx056F2C]), and FeaturedItem / UnscrappableObject /
  HasLegendary_Weapon_Cripple keywords. The base weapon keeps WeaponTypeFatman, so bowling-ball hits count.
  Test in-game.

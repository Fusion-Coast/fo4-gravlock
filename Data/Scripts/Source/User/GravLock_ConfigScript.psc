Scriptname GravLock_ConfigScript extends Quest
{Central configuration for FO4 Grav Lock. Attach to the GravLock_Config quest
(Start Game Enabled). It's a background quest only: no journal entry, objectives, markers
or messages; the player never sees it. Holds every list the car script uses, built from the game's own
records by form ID at startup and on every save load, so:
  - nothing has to be filled in by hand, on the quest or on any of the 64 vehicles
  - Nuka-World entries are added only if Nuka-World is installed (no DLC requirement)
  - changing a list in a mod update takes effect on the next load

Every form ID below is documented in docs/research/explosions.md and README.md, with the
FO4Edit Editor ID next to it. The lower six hex digits are the ID inside the file; the
load-order byte is dropped, as Game.GetFormFromFile expects.}

bool Property DebugLogging = false Auto Const
{Testing only: write a Papyrus log line for every lock, free and hit. Never shows anything
on screen. Leave false for release (the mod is then completely silent). Const on purpose:
a plain Auto property's value is stored in the save the first time the quest starts, so a
save made while testing kept logging on after the script was changed to false.}

; Built at runtime
Keyword[] ExplosiveWeaponKeywords
Keyword[] NonMovingWeaponKeywords
Form[] MovingExplosions
Keyword[] StrongActorKeywords
Form[] StrongRaces

string Property BaseGame = "Fallout4.esm" AutoReadOnly
string Property NukaWorld = "DLCNukaWorld.esm" AutoReadOnly

; ---------- startup ----------

Event OnQuestInit()
    BuildLists()
    RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndEvent

Event Actor.OnPlayerLoadGame(Actor akSender)
    BuildLists()   ; picks up list changes from mod updates, and DLC installed later
EndEvent

Function BuildLists()
    ; Explosive weapon-type keywords: a weapon with any of these moves a car with its blast.
    ExplosiveWeaponKeywords = new Keyword[0]
    AddKeyword(ExplosiveWeaponKeywords, 0x04C922, BaseGame) ; WeaponTypeExplosive
    AddKeyword(ExplosiveWeaponKeywords, 0x10C414, BaseGame) ; WeaponTypeMine
    AddKeyword(ExplosiveWeaponKeywords, 0x10C415, BaseGame) ; WeaponTypeGrenade
    AddKeyword(ExplosiveWeaponKeywords, 0x22575B, BaseGame) ; WeaponTypeMissileLauncher
    AddKeyword(ExplosiveWeaponKeywords, 0x22575C, BaseGame) ; WeaponTypeFatman (incl. the Striker)
    AddKeyword(ExplosiveWeaponKeywords, 0x219688, BaseGame) ; WeaponTypeNukaMine
    AddKeyword(ExplosiveWeaponKeywords, 0x219689, BaseGame) ; WeaponTypePlasmaMine
    AddKeyword(ExplosiveWeaponKeywords, 0x21968A, BaseGame) ; WeaponTypeBottlecapMine
    AddKeyword(ExplosiveWeaponKeywords, 0x21968C, BaseGame) ; WeaponTypeNukaGrenade
    AddKeyword(ExplosiveWeaponKeywords, 0x21968D, BaseGame) ; WeaponTypePlasmaGrenade
    AddKeyword(ExplosiveWeaponKeywords, 0x225766, BaseGame) ; WeaponTypeBroadsider

    ; Checked first: these never move a car on hit (their damage still counts).
    NonMovingWeaponKeywords = new Keyword[0]
    AddKeyword(NonMovingWeaponKeywords, 0x21A29F, BaseGame) ; WeaponTypeMolotov
    AddKeyword(NonMovingWeaponKeywords, 0x219686, BaseGame) ; WeaponTypeCryoMine
    AddKeyword(NonMovingWeaponKeywords, 0x21968B, BaseGame) ; WeaponTypeCryoGrenade
    AddKeyword(NonMovingWeaponKeywords, 0x219687, BaseGame) ; WeaponTypePulseMine
    AddKeyword(NonMovingWeaponKeywords, 0x21968E, BaseGame) ; WeaponTypePulseGrenade

    ; Approved explosions: for hits that arrive as an Explosion, only these move a car.
    MovingExplosions = new Form[0]
    ; explosive weapons
    AddForm(MovingExplosions, 0x0E574F, BaseGame) ; fragGrenadeExplosion
    AddForm(MovingExplosions, 0x1A43EF, BaseGame) ; fragGrenadeChildExplosion
    AddForm(MovingExplosions, 0x0E5752, BaseGame) ; nukaGrenadeExplosion
    AddForm(MovingExplosions, 0x17B3B2, BaseGame) ; plasmaGrenadeExplosion
    AddForm(MovingExplosions, 0x245F21, BaseGame) ; BaseballGrenadeExplosion
    AddForm(MovingExplosions, 0x0EECE9, BaseGame) ; fragMineExplosion
    AddForm(MovingExplosions, 0x123F1A, BaseGame) ; MS16fragMineExplosion
    AddForm(MovingExplosions, 0x23D535, BaseGame) ; BottleCapMineExplosion
    AddForm(MovingExplosions, 0x1C037C, BaseGame) ; TrapfragGrenadeExplosion2
    AddForm(MovingExplosions, 0x1C037B, BaseGame) ; TrapfragGrenadeExplosion3
    AddForm(MovingExplosions, 0x0FD3AA, BaseGame) ; ExplosionMissileShell
    AddForm(MovingExplosions, 0x216359, BaseGame) ; ExplosionMissileShellSmallSentry
    AddForm(MovingExplosions, 0x216362, BaseGame) ; SentryShoulderClusterExplosionChild
    AddForm(MovingExplosions, 0x1A7FF2, BaseGame) ; FatManExplosion
    AddForm(MovingExplosions, 0x1C6BFF, BaseGame) ; FatManExplosionMIRVpack
    AddForm(MovingExplosions, 0x246741, BaseGame) ; FatManExplosionMIRVchild
    AddForm(MovingExplosions, 0x118615, BaseGame) ; ExplosionBroadsiderBase
    ; big blasts in the world
    AddForm(MovingExplosions, 0x023D3B, BaseGame) ; CarNukeLargeVehicles (another car's full blast)
    AddForm(MovingExplosions, 0x1A673A, BaseGame) ; robotSelfDestructExplosion
    AddForm(MovingExplosions, 0x1AF074, BaseGame) ; robotSelfDestructExplosionLarge
    AddForm(MovingExplosions, 0x1AF075, BaseGame) ; robotSelfDestructExplosionSmall
    ; strong-enemy attacks
    AddForm(MovingExplosions, 0x144AB3, BaseGame) ; BehemothSlamExplosion
    AddForm(MovingExplosions, 0x14D17C, BaseGame) ; BehemothStompExplosion
    AddForm(MovingExplosions, 0x14BBDC, BaseGame) ; BehemothRockExplosion
    AddForm(MovingExplosions, 0x156D08, BaseGame) ; SwanSupermutantAmbushExplosion01
    AddForm(MovingExplosions, 0x121AC2, BaseGame) ; DeathclawRockExplosion
    AddForm(MovingExplosions, 0x043365, BaseGame) ; DeathclawAOEAttackExplosion
    ; Nuka-World (only if installed)
    if Game.IsPluginInstalled(NukaWorld)
        AddForm(MovingExplosions, 0x033902, NukaWorld) ; DLC04_FragGrenadeMIRVExplosionPack
        AddForm(MovingExplosions, 0x033904, NukaWorld) ; DLC04_FragGrenadeMIRVExplosion
        AddForm(MovingExplosions, 0x040CDF, NukaWorld) ; DLC04NukaCherryGrenadeExplosion
        AddForm(MovingExplosions, 0x040CE1, NukaWorld) ; DLC04NukaQuantumGrenadeExplosion
        AddForm(MovingExplosions, 0x04A61B, NukaWorld) ; DLC04RaiderOverboss_FragGrenadeSingleExplosion
        AddForm(MovingExplosions, 0x0213A9, NukaWorld) ; DLC04SentryShoulderClusterExplosionChild
        AddForm(MovingExplosions, 0x0505EA, NukaWorld) ; DLC04SentryShoulderCherryExplosion
        AddForm(MovingExplosions, 0x019418, NukaWorld) ; DLC04NukaNukeExplosion
        AddForm(MovingExplosions, 0x032F5A, NukaWorld) ; DLC04NukatronCherryExplosion
        AddForm(MovingExplosions, 0x032F5B, NukaWorld) ; DLC04NukatronQuantumExplosion
        AddForm(MovingExplosions, 0x0439F8, NukaWorld) ; DLC04NukatronColaExplosion
    endif

    ; Strong enemies: their hits move a car. Keywords cover every variant.
    StrongActorKeywords = new Keyword[0]
    AddKeyword(StrongActorKeywords, 0x0317AA, BaseGame) ; ActorTypeDeathclaw
    AddKeyword(StrongActorKeywords, 0x14F6A5, BaseGame) ; ActorTypeSuperMutantBehemoth
    StrongRaces = new Form[0]
    AddForm(StrongRaces, 0x0BB7D9, BaseGame) ; SupermutantBehemothRace (backup; covers Swan)

    Log("lists built: " + ExplosiveWeaponKeywords.Length + " explosive keywords, " \
        + NonMovingWeaponKeywords.Length + " non-moving keywords, " + MovingExplosions.Length \
        + " explosions, " + StrongActorKeywords.Length + " strong keywords, " \
        + StrongRaces.Length + " strong races")
EndFunction

Function AddKeyword(Keyword[] akList, int aiFormID, string asFile)
    Keyword k = Game.GetFormFromFile(aiFormID, asFile) as Keyword
    if k
        akList.Add(k)
    else
        Log("MISSING keyword " + aiFormID + " in " + asFile)
    endif
EndFunction

Function AddForm(Form[] akList, int aiFormID, string asFile)
    Form f = Game.GetFormFromFile(aiFormID, asFile)
    if f
        akList.Add(f)
    else
        Log("MISSING form " + aiFormID + " in " + asFile)
    endif
EndFunction

; ---------- called by GravLock_CarLockScript ----------

bool Function IsMovingHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile)
    return IsExplosiveHit(akSource, akProjectile) || IsStrongEnemy(akAggressor as Actor)
EndFunction

bool Function IsExplosiveHit(Form akSource, Projectile akProjectile)
    ; Weapons: only real explosives, and only their BLAST. A hit that carries a projectile
    ; is the grenade or missile physically touching the car (prototype runs 4-5); blasts
    ; arrive with no projectile. Explosive-legendary guns have no explosive keyword.
    Weapon w = akSource as Weapon
    if w
        if HasAnyKeyword(w, NonMovingWeaponKeywords)
            return false   ; Molotov, cryo, pulse
        endif
        if akProjectile
            return false   ; contact, not blast
        endif
        return HasAnyKeyword(w, ExplosiveWeaponKeywords)
    endif
    ; Explosions: approved list only (the car's own small CarExplosion pop isn't on it).
    Explosion e = akSource as Explosion
    if e && MovingExplosions
        return MovingExplosions.Find(e) >= 0
    endif
    return false
EndFunction

bool Function IsStrongEnemy(Actor a)
    if !a
        return false
    endif
    if HasAnyKeyword(a, StrongActorKeywords)
        return true
    endif
    return StrongRaces && StrongRaces.Find(a.GetRace()) >= 0
EndFunction

bool Function HasAnyKeyword(Form akForm, Keyword[] akKeywords)
    if !akForm || !akKeywords
        return false
    endif
    int i = 0
    while i < akKeywords.Length
        if akForm.HasKeyword(akKeywords[i])
            return true
        endif
        i += 1
    endwhile
    return false
EndFunction

Function Log(string asMessage)
    if DebugLogging
        Debug.Trace("GravLock: " + asMessage)
    endif
EndFunction

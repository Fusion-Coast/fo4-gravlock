Scriptname GravLock_CarLockScript extends ObjectReference
{FO4 Grav Lock: stops cars from killing the player on contact.

Attach to each in-scope vehicle base object (cars, pickups, Vault-Tec vans: 64 records,
see docs/research/car-records.md). No properties need filling: the lists live on the
GravLock_Config quest, which this script finds by form ID.

- On load the car keeps normal physics just long enough to come to rest, then locks
  (keyframed: solid, but nothing can push it). Cars that load mid-air fall first; cars
  stuck rattling against another object (the cause of the bug) lock within ~2 seconds.
- Player contact, melee, gunfire, fire and frost never free it.
- Freed only by: its own explosion (Papyrus destruction stage 4), an approved explosion's
  blast, or a hit from a deathclaw or behemoth. It then moves, lands and locks again.

Behavior confirmed by the prototype (docs/results/prototype-run-1..7.md).}

; ---------- tuning (defaults are the tested values; no need to change in the CK) ----------

int Property ConfigQuestID = 0x000F99 Auto Const
{Form ID of the GravLock_Config quest inside FO4GravLock.esp (lower six hex digits).
Set this to the quest's real ID after creating it (docs/build.md, step 5).}

string Property PluginName = "FO4GravLock.esp" AutoReadOnly

int Property ExplodeStage = 4 Auto Const
{Papyrus destruction stage of the big explosion (= FO4Edit DSTD index 3 + 1). Earlier stages
(burning, the small pop) keep the car locked. Confirmed in prototype runs 1-3.}

float Property CheckInterval = 0.5 Auto Const
{Seconds between "has it stopped moving?" checks while settling.}

float Property RestDistance = 2.0 Auto Const
{Game units the car may drift between checks and still count as at rest.}

float Property RestAngle = 1.0 Auto Const
{Degrees the car may rotate between checks and still count as at rest.}

int Property RestChecksNeeded = 2 Auto Const
{Consecutive at-rest checks required before locking.}

float Property RattleTime = 2.0 Auto Const
{A car still moving after this many seconds but within RattleRadius of where it started
is rattling against something (the Quincy Red Rocket case), not falling: lock it.}

float Property RattleRadius = 30.0 Auto Const
{Game units. A falling or tumbling car travels much farther than this.}

float Property MaxSettleTime = 20.0 Auto Const
{Backstop: lock after this many seconds no matter what. Build run 1: an exploding car
spun through the air for ~10 s, and the old 8 s backstop locked it mid-flight. Rattle
detection still catches stuck cars within ~2 s, so a long backstop costs nothing.}

int SettleTimerID = 1 Const

GravLock_ConfigScript config
bool locked
int restChecks
float settleElapsed
float lastX
float lastY
float lastZ
float lastAX
float lastAY
float lastAZ
float startX
float startY
float startZ

; ---------- events ----------

Event OnLoad()
    BeginSettle()
EndEvent

Event OnUnload()
    CancelTimer(SettleTimerID)
    UnregisterForAllHitEvents()
EndEvent

Event OnDestructionStageChanged(int aiOldStage, int aiCurrentStage)
    ; Its own explosion: only when crossing INTO the explosion stage. The final stage after
    ; it (5, the burnt-out hulk) arrives later and must not free the car again (build run 1).
    if aiOldStage < ExplodeStage && aiCurrentStage >= ExplodeStage
        Log("own explosion (stage " + aiCurrentStage + "), freed")
        FreeCar()
        BeginSettle()
    endif
EndEvent

Event OnHit(ObjectReference akTarget, ObjectReference akAggressor, Form akSource, Projectile akProjectile, \
    bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked, string apMaterial)
    GravLock_ConfigScript c = GetConfig()
    if c && c.IsMovingHit(akAggressor, akSource, akProjectile)
        Log("hit by " + akSource + " from " + akAggressor + " (projectile " + akProjectile + "), freed")
        FreeCar()
        BeginSettle()
    else
        Log("hit by " + akSource + " from " + akAggressor + " (projectile " + akProjectile + "), ignored")
        if locked
            RegisterForHitEvent(self)   ; hit events are one-shot
        endif
    endif
EndEvent

Event OnTimer(int aiTimerID)
    if aiTimerID != SettleTimerID || locked
        return
    endif
    settleElapsed += CheckInterval
    if IsAtRest()
        restChecks += 1
    else
        restChecks = 0
    endif
    bool rattling = IsRattling()
    RecordPose()
    if restChecks >= RestChecksNeeded || rattling || settleElapsed >= MaxSettleTime
        LockCar()
    else
        StartTimer(CheckInterval, SettleTimerID)
    endif
EndEvent

; ---------- lock / free (not Lock/Unlock: ObjectReference already has those, for doors) ----------

Function BeginSettle()
    locked = false
    restChecks = 0
    settleElapsed = 0.0
    RecordPose()
    startX = lastX
    startY = lastY
    startZ = lastZ
    StartTimer(CheckInterval, SettleTimerID)
EndFunction

Function LockCar()
    CancelTimer(SettleTimerID)
    SetMotionType(Motion_Keyframed)
    locked = true
    RegisterForHitEvent(self)
    Log("locked after " + settleElapsed + " s")
EndFunction

Function FreeCar()
    CancelTimer(SettleTimerID)
    UnregisterForAllHitEvents()
    SetMotionType(Motion_Dynamic)
    locked = false
EndFunction

; ---------- rest detection ----------

Function RecordPose()
    lastX = GetPositionX()
    lastY = GetPositionY()
    lastZ = GetPositionZ()
    lastAX = GetAngleX()
    lastAY = GetAngleY()
    lastAZ = GetAngleZ()
EndFunction

bool Function IsAtRest()
    float dx = GetPositionX() - lastX
    float dy = GetPositionY() - lastY
    float dz = GetPositionZ() - lastZ
    if Math.Sqrt(dx * dx + dy * dy + dz * dz) > RestDistance
        return false
    endif
    if AngleDelta(GetAngleX(), lastAX) > RestAngle
        return false
    endif
    if AngleDelta(GetAngleY(), lastAY) > RestAngle
        return false
    endif
    return AngleDelta(GetAngleZ(), lastAZ) <= RestAngle
EndFunction

bool Function IsRattling()
    if settleElapsed < RattleTime
        return false
    endif
    float dx = GetPositionX() - startX
    float dy = GetPositionY() - startY
    float dz = GetPositionZ() - startZ
    return Math.Sqrt(dx * dx + dy * dy + dz * dz) <= RattleRadius
EndFunction

float Function AngleDelta(float a, float b)
    float d = Math.Abs(a - b)
    if d > 180.0
        d = 360.0 - d
    endif
    return d
EndFunction

; ---------- helpers ----------

GravLock_ConfigScript Function GetConfig()
    if !config
        config = Game.GetFormFromFile(ConfigQuestID, PluginName) as GravLock_ConfigScript
    endif
    return config
EndFunction

Function Log(string asMessage)
    GravLock_ConfigScript c = GetConfig()
    if c && c.DebugLogging
        Debug.Trace("GravLock " + self + ": " + asMessage)
    endif
EndFunction

; ---------- still to confirm in full testing ----------
; - Deathclaw hits and rock throws (behemoth swing + slam confirmed in run 6)
; - Throwing: can a creature pick up and throw a locked car? If the game frees it for a
;   throw without an event, it could land unlocked (not observed so far)
; - Every in-scope model explodes at stage 4 (confirmed for CarSportsCar07)
; - Rattle detection on the Quincy car (the prototype locked instantly; this settles first)
; - Performance with 30+ cars (docs/testing.md)

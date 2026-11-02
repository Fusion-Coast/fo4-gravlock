Scriptname GravLock_ProtoLock extends ObjectReference
{PROTOTYPE ONLY. Proves the core idea and answers the open questions with on-screen
messages. Attach to CarSportsCar07 (the Quincy car) and CarSedan01 for the prototype test, then remove before building the
real mod. See docs/prototype.md.

What it does:
- Locks the car (keyframed) as soon as it loads. No settling yet: spawn it on the ground.
- Shows every destruction stage change, so we learn the real stage numbers.
- Shows what every hit reports (weapon or explosion, and who), so we learn how
  explosions and strong-enemy hits arrive.
- Frees the car on its own explosion stage, or on any explosive hit, so we can see
  whether the blast still throws it (timing test).}

int Property ExplodeStage = 4 Auto Const
{Run 1 showed Papyrus stage = FO4Edit DSTD index + 1, so the big explosion is stage 4.}

Explosion Property CarExplosion Auto Const
{Fill with CarExplosion [EXPL:00022496]: the car's own small pop at the start of the burn.
Ignored, so it doesn't free the car (run 1 showed it hits the car itself).}

Keyword Property WeaponTypeExplosive Auto Const
{Fill with WeaponTypeExplosive [KYWD:0004C922].}

bool locked

Event OnLoad()
    SetMotionType(Motion_Keyframed)
    locked = true
    RegisterForHitEvent(self)
    Debug.Notification("GravLock proto: LOCKED " + self)
    Debug.Trace("GravLock proto: LOCKED " + self + " stage " + GetCurrentDestructionStage())
EndEvent

Event OnUnload()
    UnregisterForAllHitEvents()
EndEvent

Event OnDestructionStageChanged(int aiOldStage, int aiCurrentStage)
    Debug.Notification("GravLock proto: stage " + aiOldStage + " -> " + aiCurrentStage)
    Debug.Trace("GravLock proto: stage " + aiOldStage + " -> " + aiCurrentStage)
    if aiCurrentStage >= ExplodeStage && locked
        Free("own explosion, stage " + aiCurrentStage)
    endif
EndEvent

Event OnHit(ObjectReference akTarget, ObjectReference akAggressor, Form akSource, Projectile akProjectile, \
    bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked, string apMaterial)
    string kind = "other"
    if akSource as Explosion
        kind = "EXPLOSION"
    elseif akSource as Weapon
        kind = "WEAPON"
    endif
    string msg = "GravLock proto: hit by " + kind + " " + akSource + " from " + akAggressor
    Debug.Notification(msg)
    Debug.Trace(msg + " projectile " + akProjectile)

    bool explosive = (akSource as Explosion) != None && akSource != CarExplosion
    Weapon w = akSource as Weapon
    if w && WeaponTypeExplosive && w.HasKeyword(WeaponTypeExplosive)
        ; Run 4 rule: a hit WITH a projectile is the grenade/missile physically touching the
        ; car (e.g. a grenade bouncing off it before its fuse runs out). Only a hit with NO
        ; projectile is the blast itself.
        if akProjectile
            Debug.Notification("GravLock proto: explosive CONTACT ignored")
            Debug.Trace("GravLock proto: explosive CONTACT ignored, waiting for the blast")
        else
            explosive = true
        endif
    endif

    if explosive && locked
        Free("explosive hit")
    else
        RegisterForHitEvent(self)   ; hit events are one-shot
    endif
EndEvent

Function Free(string reason)
    SetMotionType(Motion_Dynamic)
    locked = false
    Debug.Notification("GravLock proto: FREED (" + reason + ")")
    Debug.Trace("GravLock proto: FREED (" + reason + ") " + self)
EndFunction

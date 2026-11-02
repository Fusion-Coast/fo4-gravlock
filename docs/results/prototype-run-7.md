# Prototype run 7 (2026-11-01): Test E, persistence — PASS

At Drumlin Diner (well outside the Sanctuary cell).

| Time | Event |
|---|---|
| 09:29:10 | Loading game... |
| 09:29:48 | LOCKED 000F1E03 (a placed car, after loading the save) |
| 09:32:14 | Spawned car LOCKED (FF00183C), clipped slightly into the ground (vanilla), didn't move |
| 09:32:46 | autosave: fast travel to Sanctuary |
| 09:33:24 | autosave: fast travel back |
| 09:33:43 | **LOCKED again (FF00183C)** |

User: car still present and locked after returning; didn't see the LOCKED message (it fired during the
load-in fade, per the log).

Save/load: every run's log shows placed cars LOCKED seconds after "Loading game...", so re-locking after a
save is loaded is covered.

# Prototype phase: COMPLETE

| Test | Result |
|---|---|
| A: the bug (Quincy CarSportsCar07) | PASS: locked, harmless (run 1) |
| B: own explosion | PASS: locked while burning, thrown by the blast at stage 4 (run 3) |
| C: grenades / missiles | PASS: only the blast frees a car, not contact (runs 4-5) |
| D: strong enemies (behemoth) | PASS: weapon hit + slam explosion both recognized (run 6) |
| E: persistence | PASS: re-locks after travel and load (run 7) |

Fixes found by the prototype and applied to the real script: ExplodeStage 4 (Papyrus = DSTD + 1), the car's
own CarExplosion pop doesn't free it, explosive-weapon contact (hits with a projectile) doesn't free it.
Not needed: backup impulses (cars are thrown by their own and outside blasts).

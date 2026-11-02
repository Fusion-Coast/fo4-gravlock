# Build run 4 (2026-11-01): deathclaw, Molotov, frag grenades

Same spot as the behemoth test (north of the Lexington Super-Duper Mart).

## Log findings
- **Deathclaw:** DeathclawIntimidateExplosion (00031ECC, its roar) reached three cars as an Explosion hit:
  **ignored** (correct: a fear effect, not on the approved list). No swipe hits on cars and no throws recorded.
  Swipes would use the same strong-enemy check that worked for the behemoth (ActorTypeDeathclaw).
- **Molotov:** Form 0010C3C6, **projectile None**, ignored. Key result: a Molotov arrives without a projectile,
  like a real blast, so the contact rule alone wouldn't stop it; the **Molotov keyword exclusion** did.
- **Frag grenades (000EEBED):** contact hits (projectile 000E574E) ignored; blast hits ~2 s later (projectile
  None) freed cars, often several from one grenade.
- **Car full blast (00023D3B):** freed intact neighbors every time. Follow-up form 00083D0C ignored when the
  player caused the explosion.
- Placed cars: 164 locked at 1.0 s, 10 at 1.5 s, 5 at 2.0 s, a few at 2.5-3.5 s. No suspended stacks.

## Status
Testing complete for release, except deferred items: Concord deathclaw throw (normal playthrough), optional
30-car comparison without the plugin, cryo and pulse grenades (covered by the same exclusion that caught the
Molotov).

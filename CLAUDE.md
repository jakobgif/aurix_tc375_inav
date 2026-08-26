# AURIX TC375 INAV FIU — Project Context

Always load at session start: `../guidelines_core.md`

## Context Loading Rules

| Task | Additional files to load |
|------|--------------------------|
| FIU Detection / Mitigation (`fiu_detection.c`) | `../guidelines_fiu.md` |
| FIU Injection (`fiu.c`, `fiu.h`) | `../guidelines_fiu.md` |
| Logic Conditions / RC Mapping (`config.c`) | `../guidelines_lc.md` |
| Hardware / Pins / LED Strip | `../guidelines_hardware.md` |
| INAV internals (scheduler, pipeline, sensors) | `../guidelines_architecture.md` |
| Thesis schreiben | `../thesis_status.md`, `../thesis_writing_guide.md` |

## Active Branches (inav_tc375 submodule)

- `inav_fiu_main` — FIU injection, LED, RC Loss, Battery fault, **+ Fault Detection** (Detection am 2026-07-27 per Merge-Commit reingemergt)
- `inav_fiu_detection` — historisch, Inhalt jetzt in `inav_fiu_main`; Branch bewusst nicht gelöscht (volle Commit-Historie)
- `inav_fiu_mitigation` — **aktueller Arbeits-Branch**, abgezweigt von `inav_fiu_main` (nach dem Detection-Merge)

## Critical Reminders

- ⚠️ **`USE_LED_STRIP` NIEMALS in `target.h` definieren** — INAVs LED-Subsystem (`io/ledstrip.c` + `light_ws2811strip.c`) hängt das Board vor dem Scheduler auf → Configurator „No configuration received within 10 seconds". Die FIU-LEDs laufen über den eigenen Treiber `fiu/fiu_ws2811.c`. Siehe `guidelines_core.md` Known Issue #3.
- `USE_FIU` muss als IDE Preprocessor Define gesetzt sein (nicht in target.h) — nach jedem `.cproject`-Update prüfen
- `USE_FIU` fehlt in der **Debug**-Build-Config (`.cproject` hat es nur unter `BUILD_CONFIG_RELEASE`) — ein Debug-Build kompiliert sonst allen FIU-Code weg
- `USE_AURIX_MULTICORE` ebenfalls als IDE Define
- `USE_FIU` ist auch in `.vscode/c_cpp_properties.json` unter `defines` eingetragen — notwendig damit VS Code IntelliSense `#ifdef USE_FIU` Blöcke auflöst und Referenzsuche funktioniert
- INAV src root: `inav_tc375/src/main/`
- Submodule-Branches separat wechseln: `cd inav_tc375` → `git checkout <branch>`

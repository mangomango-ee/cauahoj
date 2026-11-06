# Washing MVP – playable prototype (6 Nov 2026)

This is an **isolated demonstration**, not a replacement for the existing Roblox Studio project. The main branch remains unchanged.

## Install in Roblox Studio
1. Open your **test copy** of the place. In Explorer create a **Script** in `ServerScriptService` named `WashingDemo`. Paste `ServerScriptService/WashingDemo.server.luau` into it.
2. In `StarterPlayer > StarterPlayerScripts`, create a **LocalScript** named `WashingClient`. Paste `StarterPlayerScripts/WashingClient.client.luau`.
3. Press **Play**, equip **Demo Water Gun**, aim at a dirty egg, and hold left mouse (desktop) or WASH (mobile, screen center).
4. Go to **Water Station** and use the proximity prompt to refill.
5. Verify coins increase **per removed dirt unit**, not when an egg is completed. The eggs reset after ten seconds.
6. To test saving coins across sessions, publish the **test place** and enable **Game Settings > Security > Enable Studio Access to API Services**. DataStore calls are protected by pcall, so washing still works if persistence is unavailable.

## What this builds
- Three egg targets, each with visible dirt remaining (50/75/100).
- Server-validated distance, tool, raycast, water and fire-rate; coin credit only for dirt actually removed.
- Level 1 gun Power 1 and tank 30, with 1 water/second consumption; server-managed water.
- Coin leaderboard and periodic DataStore persistence (`WashingMVP_Coins_v1`).
- One refill station and a small demo field under `Workspace/WashingMVP_Demo`.

## Limitations and next step
- The remote only works on these generated demo eggs. Existing world items are not migrated.
- This is **not Studio-tested** and is **not synced automatically** to the place.
- No gun visuals, particle stream, rebirths, pet hatching, power tiers or upgrades yet.
- The UI follows touch or mouse interaction; on touch the player aims using the center of the camera.
- Attach the actual exported Roblox place/scripts before integrating with the real economy (avoid two independent Coins leaderboards).

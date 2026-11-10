# Wash Your Egg — předání pro ChatGPT / Codex (10. 11. 2026)

Dřívější název: Dewdrop Valley / Clean Your World. Starý, prázdný handoff z 24. 10. je v `HANDOFF_OLD_2026-10-24.md`.

> **Poctivost stavu:** U každé položky je označeno, co je *ověřeno*, co je jen *tvrzení uživatele* a co je *neznámé*. Nic nepovažuj za hotové, dokud to neuvidíš ve Studiu na screenshotu.

## 1. Pravidla spolupráce (platí vždy)
1. Aktuální výslovné zadání uživatele má přednost před starými poznámkami. Nemeň vzhled, mechaniky ani směr projektu na vlastní pěst. Rutinní technické kroky v rámci zadání dělej samostatně.
2. Vylepšení navrhuj stručně (přínos, nevýhoda, pracnost). Pokud nápad mění zadání, nejdřív ho navrhni a počkej na rozhodnutí.
3. Ověřuj shodu s vizí uživatele: ptej se u důležitých rozhodnutí a po vizuálních milnících, vždy jednu konkrétní otázku (nebo 2–3 možnosti). Ukaž skutečný náhled. Neptej se znovu na vyřešené věci.
4. Ponech si poučení z ověřených chyb (co selhalo, ověřená příčina, co pomohlo). Neopakuj neúspěšný postup bez nové příčiny.
5. Udržuj krátký aktuální stav (hotovo a ověřeno / zbývá / rozhodnutí / další krok). Bez duplicit.
6. Šetři: načítej jen potřebné skripty a objekty, žádné velké dumpy ani opakované kontroly. Šetření nikdy nesmí znamenat špatný nebo nefunkční kód.
7. Komunikuj stručně, upřímně a jednoduše česky. Nikdy netvrď, že je něco uložené, funkční nebo otestované, pokud to není ověřené.

## 2. Povinná smyčka pro vizuální práci
Hlavní stížnost uživatele na dosavadní AI práci: výsledek nevypadá jako jeho reference.
1. Udělej změnu ve Studiu.
2. Pořiď screenshot (screen_capture) ze stejného úhlu jako reference.
3. Porovnej s referencí a vypiš konkrétní rozdíly.
4. Oprav a opakuj, dokud rozdíly nezmizí. Nepiš „hotovo“ bez screenshotu a seznamu toho, co ještě nesedí.
5. Žádné koule na hnědých kmenech, žádné stejné stromy, žádné chybějící textury. Modely (stromy, útesy, truhly, vejce) dělej z kvalitních meshů (Blender nebo hotové assety), ne z primitivních dílů.

## 3. Vize hry
Hráč myje svět tlakovou myčkou („wapka“), nosí na zádech nádrž s vodou, která se vyprázdní, a z umytých vajec získává mazlíčky. Cílový dojem: klasická hra, jakou chtějí děti vidět (Steal an Egg / Steal a Brainrot).

## 4. Styl (tvrdé zadání)
- Velmi podobný Pet Simulator 99: barevný, čistý, příjemný cartoon, chunky low-poly stromy s vrstvenými korunami, pastelové budovy, krémové rámy, tyrkysové a zlaté akcenty. Čerstvá paleta, ne podzimní oranžová.
- **Ne:** Lego vzhled (studs, výchozí plast), fotorealismus, realistické špinavé textury, horor, přeplácaná fantasy.

## 5. Mapa
- Dlouhá obdélníková mapa. Spawn na levém konci, vedle sebe světy/zóny 1, 2, 3… (~10 zón odemykaných silou mazlíčků a myčky).
- Zóny odděluje bílá čára a průhledná bariéra s názvem zóny (žádná brána). První zóna se jmenuje **Plains**.
- Okraj mapy: vysoké šedé skalní útesy. Podle nové uživatelovy reference: hranaté břidlicově šedé desky v tmavých i světlých odstínech, travnaté terasovité římsy a barevné stupňovité růžové i kulaté stromy.
- Les: pestré stromy (růžové, modré, zelené), každý jiný. Vlastní modely (pařezy, popadané kmeny, mech, potok), občas malá věž nebo rozhledna, kopce jen místy.
- Svět 1: věci k mytí se spawnují různě velké, velikost určuje, jak se myjí (například velký špinavý strom).
- Mapa se staví podle uživatelovy skici, spawn mnohem jednodušší než v referenci.

## 6. Spawn hub
- Kruhový spawn na červeném koberci. Uprostřed kreslený dětský autobus (bez hada) na doplňování vody, nádrž na střeše, nad ním plovoucí text „REFILL HERE!“ otočený vždy k hráči, kolem kreslené kostky.
- Rebirth oltář, truhly (viz 8), tři obchody (viz 7).

## 7. Obchody (podle uživatele postavené, nepřestavovat)
- Tři dřevěné stánky podle jeho 4pohledových konceptů, pruhovaná stříška, nováček za pultem: **WATERGUN STORE** (velká oranžová pistole s modrou nádrží nahoře), **WATER TANK STORE** (velká modrá nádrž s kohoutkem), **PET STORE** (identický stánek, fialová pruhovaná stříška).
- Titulek je na samostatné dřevěné závěsné ceduli před stánkem, na střeše zůstává jen pistole nebo nádrž.
- Tři water guns a tři nádrže na záda, dražší tier vypadá epičtěji.

## 8. Truhly
- **Daily Chest** fialová, **Group Chest** modrá (zlaté pásy, zámek), obě s cooldownem 24 h. Nad nimi kreslený text „DAILY CHEST“ / „GROUP CHEST“ a odpočet „UNLOCKS IN: 7h“ (tlusté zaoblené písmo, žlutá až oranžová, černý obrys, tmavá extruze) přesně podle uživatelových referencí.
- Mince z truhel se škálují podle levelu hráče.
- Modely z Blenderu, importované do Roblox.

## 9. Ekonomika a vejce
- Hráč vydělává mytím věcí ve světě.
- Umývatelná vejce se spawnují s nižší šancí než běžné věci a po umytí dají mazlíčka.
- Vejce mají rarity (návrh má uživatel hotový, vyžádej si ho).
- Vejce: slonovinově bílé, v zemi napůl zahrabané, silný efekt hrud hlíny kolem (tráva vítaná), části `CleanEgg`, `GroundRing`, volitelně `DirtOverlay`. První verze byla zamítnuta jako slabá.
- Sprej: kreslený efekt stříkající vody k myši při držení levého tlačítka, kvalitní animace mytí.

## 10. Co je hotové a co zbývá
**Tvrzení uživatele / dřívější práce (neověřeno 10. 11.):** obchody a závěsné ceduli postavené; truhly vymodelované v Blenderu; designové rozhodnutí o spawnu, zónách a ekonomice.

**Ověřeno ve Studiu 10. 11. 2026:** otevřený projekt „Untitled Experience“ (placeId 75333015270789) obsahuje:
- `ServerScriptService.Server.Main` (jediný skript)
- `ReplicatedStorage.Shared` s moduly Remotes, StatMath, Util a složkou Config (Achievements, Classes, Cleaning, Dev, Economy, Gamepasses, Guns, GunVisuals, Icons, Lobby, Maps, Pets, PetVisuals, Quests, Sounds, Story, Tanks, Tutorial, Upgrades, VolumeDirt)
- `Workspace.Lobby` (Spawn, ProfessorSplash, LobbySpawn), `Workspace.Runs`, `Workspace.__Bench` (testovací kousky: stromy, květiny, země, trubky, cedule, materiály, shopkit)

**Nesrovnalost:** autobus, tři stánky, truhly ani dlouhá mapa se zónami ve Studiu nalezeny nebyly. Díly v `__Bench` (05_playhere, 06_bays, 09_disc, 10_sign, 11_shopkit, 13_trees atd.) odpovídají nově dodanému referenčnímu listu lobby v `assets/references/` (obchody Upgrades/Rewards/Classes/Shop, Play Here, disk). Studio je tedy rozpracované lobby podle těchto referencí. To se liší od starších poznámek (autobus, stánky, truhly, „žádné Lego studs“). Aktuální zadání uživatele z 10. 11. je lobby podle `lobby_scene.png` a `lobby_parts_sheet.png`, ty mají přednost. Pokud se styl (Lego cihly se studs) a starý autobus/stánky vylučují, zeptej se uživatele. Neničit existující kód. Postup viz `GAUNTLET.md`.

**Zbývá (podle zadání):** nová dlouhá mapa se zónami a bariérami, útesy podle reference, les s pestrými stromy, spawn hub s autobusem, rebirth oltář, vejce s raritami a efektem zahrabání, sprej a animace mytí, ekonomika, truhly v hře s odpočtem, import a rozmístění modelů.

## 11. Reference obrázky
Uživatel je posílal v chatu, v repu zatím nejsou. Popisy: fantasy les (modré, růžové, fialové a zelené koruny, mechové skály, popadaný kmen, tyrkysový potok, cesta, skalnatý kopec); útesy (hranaté břidlicově šedé desky, travnaté římsy, barevné stupňovité stromy); truhly (5pohledové listy, fialová Daily a modrá Group s textem „DAILY CHEST“ / „GROUP CHEST“); stánky (4pohledové koncepty); autobus a stánek-reference od uživatele. **Vyžádej si originály a ukládej je do `assets/references/`.**

## 12. Další krok
Zeptej se uživatele (jednou, konkrétně), které Studio/verze je správná, a pošli referenční obrázky do `assets/references/`. Potom začni mapou: staví se po zónách, každá zóna se ověřuje screenshotem proti referenci.

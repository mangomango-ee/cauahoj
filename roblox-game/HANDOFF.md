# Předání Roblox projektu — 24. 10. 2026

> **DŮLEŽITÉ: Projekt zatím není kompletní.** V tomto repozitáři v době vytvoření tohoto dokumentu nejsou dostupné žádné původní soubory Roblox hry ani export Roblox Studio světa. Nepředstírej, že hra už byla přenesena.

## Původ
- Roblox hra vyvíjená 24. 10. 2026 pomocí Codexu.
- **Nejedná se o Brainrot Factory.** Nezaměňovat starší projekt s tímto.
- Uživatel chce předat stav práce jinému ChatGPT/Codexu, aby pokračoval bez ztráty kontextu.
- Uživatel poskytl odkaz na původní sdílenou relaci: https://chatgpt.com/s/cx_6adc943ed96c8191a9b41cd2fb285c70
- Obsah původní relace nebyl v tomto chatu přístupný, proto z něj nelze potvrdit koncept, gameplay, funkční skripty ani aktuální úkoly.

## Stav ověření
| Oblast | Stav |
|---|---|
| Přístup ke GitHub repozitáři | Ověřen |
| Předávací adresář | Vytvořen |
| Soubor HANDOFF.md | Vytvořen |
| Originální Roblox svět (.rbxl/.rbxlx) | **NEDODÁN** |
| Skripty z původní relace | **NEDODÁNY** |
| Assety, modely, UI | **NEDODÁNY** |
| Funkčnost hry | **NEOVĚŘENA** |
| Koncept a požadavky původní hry | **NEZNÁMÉ** |

## Adresářová struktura
- `world/` — sem patří export Roblox Studio place/world (`.rbxl` nebo `.rbxlx`).
- `scripts/` — sem patří exportované Roblox Lua/Luau skripty a ModuleScripty; popis umístění v hierarchii hry.
- `assets/` — sem patří samostatně exportované obrázky, modely, UI a další zdroje, pokud existují.
- `README.md` — návod pro předání.
- `HANDOFF.md` — současný stav projektu a otevřené úkoly.

## Co je potřeba získat z původního prostředí
1. Celý Roblox Studio svět: otevřít místo v Roblox Studiu a použít **File → Save to File**; uložit `.rbxl` nebo `.rbxlx`.
2. Pokud existují soubory v Codex workspace, přenést celou projektovou složku včetně skutečných skriptů a konfiguračních souborů.
3. Pokud Codex pracoval s GitHub repozitářem, dodat URL správného repozitáře a větev nebo commit.
4. Přenést původní konverzaci / detailní shrnutí, zejména zadání, změny, známé chyby, poslední testy a plánované kroky.
5. Ověřit přes Play Test v Roblox Studiu, co funguje; žádný funkční stav nyní potvrzený není.

## Pokyny pro navazujícího asistenta
- Nezačínej tvorbu Brainrot Factory ani nepředpokládej její specifikaci.
- Nejprve ověř dostupnost reálných projektových souborů v `world/`, `scripts/` a `assets/`.
- Pokud zde jsou pouze popisné README soubory, projekt **je stále nutné importovat**.
- Po získání zdrojů vytvoř soupis hierarchie Roblox Exploreru a konkrétních skriptů, jejich funkcí, testů, chyb a dalšího postupu.
- Nedělej závěry o existujícím gameplayi nebo hotových mechanikách bez důkazů ze souborů.
- Pro další práci ověř, zda byl poslední commit skutečně pushnutý do GitHubu.

## Otevřené úkoly
- [ ] Získat skutečný Roblox svět a importovat do `world/`.
- [ ] Získat reálné skripty a umístit do `scripts/`, případně ponechat původní projektovou strukturu.
- [ ] Přidat existující assety do `assets/`.
- [ ] Doplnit herní koncept, požadavky a dosavadní rozhodnutí podle původní konverzace.
- [ ] Otestovat funkčnost v Roblox Studiu.
- [ ] Doplnit úplný plán dalších úprav.

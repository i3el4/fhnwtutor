# Business Analytics Tutor — Einrichtung

Freiwilliges Angebot, selbst gebaut, kein Bestandteil des Unterrichts. Kein Support, keine Gewähr.

Der Gemini Free Tier übermittelt markierten Text an Google; Google kann ihn zur Produktverbesserung verwenden. Keine Matrikelnummern, Klausurdaten oder Datensätze mit Personenbezug durchschicken.

---

## 1. Paket installieren

R 4.3 oder neuer und [RStudio Desktop](https://posit.co/download/rstudio-desktop/). In der Console:

```r
install.packages("fhnwtutor", repos = c("https://i3el4.r-universe.dev", getOption("repos")))
```

## 2. Eigenen API-Key

Jede Person braucht einen eigenen kostenlosen Key von [Google AI Studio](https://aistudio.google.com/apikey). Keys nicht weitergeben.

In R:

```r
file.edit(path.expand("~/.Renviron"))
```

Eine Zeile, Key direkt hinter dem Gleichheitszeichen, ohne Anführungszeichen:

```
GEMINI_API_KEY=
```

Speichern. RStudio vollständig beenden und wieder öffnen (nicht nur Session → Restart R).

## 3. Tastenkürzel

Tools → Modify Keyboard Shortcuts… → nach `Business Analytics Tutor` suchen.

- Windows: `Ctrl+Alt+C`
- macOS: `Ctrl+Cmd+C`

## 4. Test

Zeile markieren, Tastenkürzel, **Umsetzen** anklicken:

```r
wie lade ich meine excel datei hier hinein, damit ich damit arbeiten kann?
```

---

## Wenn etwas hakt

| Symptom | Typische Ursache |
|--------|------------------|
| Paket nicht verfügbar | Tippfehler in der `repos`-URL, oder R älter als 4.3 |
| Meldung, dass kein API-Key gefunden wurde | Zeile fehlt in `.Renviron`, Leerzeichen um `=`, oder RStudio nicht komplett neu gestartet |
| Tastenkürzel macht nichts | Nach `Business Analytics Tutor` suchen, nicht nach `Chores` |
| Quota-Meldung von Google | Free-Tier-Limit; später erneut versuchen |

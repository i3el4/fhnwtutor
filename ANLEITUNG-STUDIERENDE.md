# Business Analytics Tutor — Einrichtung

Freiwilliges Angebot für die Lehrveranstaltung Business Analytics. Das Add-in ist selbst gebaut, kein Bestandteil des Unterrichts. Es gibt keinen Support und keine Gewähr für Funktion oder Verfügbarkeit.

Der Gemini Free Tier übermittelt den markierten Text an Google. Google kann diese Inhalte zur Produktverbesserung verwenden. Deshalb keine vertraulichen oder personenbezogenen Daten durchschicken: keine Matrikelnummern, keine Klausurdaten, keine Datensätze mit Personenbezug.

Paketname in R: `fhnwtutor`.

---

## 1. R und RStudio

1. [R](https://cran.r-project.org) installieren, Version 4.3 oder neuer.
2. Danach [RStudio Desktop](https://posit.co/download/rstudio-desktop/) installieren.
3. RStudio öffnen. In der Console muss eine Zeile mit `R version 4.3` oder höher stehen.

## 2. Paket installieren

In der RStudio-Console:

```r
install.packages("fhnwtutor", repos = c("https://i3el4.r-universe.dev", getOption("repos")))
```

Kein GitHub-Konto, kein Token. Die Abhängigkeiten `chores` und `ellmer` kommen mit.

Zusätzlich, nur zum Öffnen der Konfigurationsdateien:

```r
install.packages("usethis")
```

## 3. Eigenen Gemini-API-Key holen

Jede Person braucht einen eigenen Key. Keys nicht teilen, nicht per Mail oder Chat schicken, nicht ins Git-Repo legen.

1. Unter [Google AI Studio](https://aistudio.google.com/apikey) mit einem Google-Konto anmelden.
2. Einen API-Key erzeugen und kopieren.

## 4. Key eintragen und RStudio neu starten

```r
usethis::edit_r_environ()
```

Eine Zeile einfügen. Den Key direkt hinter das Gleichheitszeichen setzen, ohne Anführungszeichen und ohne Leerzeichen:

```
GEMINI_API_KEY=
```

Speichern, Datei schliessen. RStudio vollständig beenden und wieder öffnen. Session → Restart R reicht nicht.

Zur Kontrolle:

```r
nzchar(Sys.getenv("GEMINI_API_KEY"))
```

Erwartung: `TRUE`.

## 5. Konfiguration ins `.Rprofile`

```r
usethis::edit_r_profile()
```

Diese Zeilen einfügen oder an bestehenden Inhalt anhängen:

```r
# Business Analytics Tutor – Gemini Free Tier
if (interactive()) {
  options(
    chores.chat = ellmer::chat_google_gemini(
      model = "gemini-3.5-flash",
      api_args = list(
        generationConfig = list(
          thinkingConfig = list(thinkingLevel = "minimal")
        )
      )
    )
  )
  library(fhnwtutor)
}
```

Speichern, Datei schliessen. RStudio erneut vollständig neu starten.

Zur Kontrolle:

```r
"fhnwtutor" %in% loadedNamespaces()
```

Erwartung: `TRUE`.

## 6. Tastenkürzel

1. Tools → Modify Keyboard Shortcuts…
2. Nach `Chores` suchen.
3. Zuweisen:
   - Windows: `Ctrl+Alt+C`
   - macOS: `Ctrl+Cmd+C`

## 7. Funktionstest

Neues R-Skript, diese Zeile markieren:

```r
wie lade ich meine excel datei hier hinein, damit ich damit arbeiten kann?
```

Tastenkürzel drücken, **Umsetzen** anklicken. Die Zeile sollte durch R-Code mit `readxl` ersetzt werden.

Die anderen Knöpfe: Kommentieren, Erweitern, Erklären, Bereinigen.

---

## Wenn etwas hakt

| Symptom | Typische Ursache |
|--------|------------------|
| `package ‘fhnwtutor’ is not available` | r-universe hat das Paket noch nicht gebaut, Tippfehler in der `repos`-URL, oder R älter als 4.3 |
| `"fhnwtutor" %in% loadedNamespaces()` ist `FALSE` | `.Rprofile` ohne `library(fhnwtutor)`, oder RStudio nicht vollständig neu gestartet |
| Fehlermeldung zu API oder authentication | Key fehlt, Tippfehler in `.Renviron`, Leerzeichen um das `=`, oder Neustart vergessen |
| `nzchar(Sys.getenv("GEMINI_API_KEY"))` ist `FALSE` | Zeile steht nicht in `.Renviron`, oder RStudio nach dem Speichern nicht komplett neu gestartet |
| Tastenkürzel macht nichts | Anderes Kürzel belegt dieselbe Kombination; in den Shortcuts erneut `Chores` suchen |
| Knöpfe ohne Umsetzen / Erklären | `library(fhnwtutor)` wurde in dieser Session nicht ausgeführt |
| Quota- oder Rate-Limit-Meldung von Google | Free-Tier-Limit erreicht; später erneut versuchen, eigenen Key verwenden |

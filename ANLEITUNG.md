# Einrichtung von fhnwtutor (Windows)

Kurzanleitung für die Kollegin: RStudio-Add-in mit denselben fünf Assistenten wie auf dem Mac.

Du brauchst:

- [R](https://cran.r-project.org) (Version 4.3 oder neuer) und [RStudio Desktop](https://posit.co/download/rstudio-desktop/)
- ein GitHub-Konto (Einladung zum privaten Repo `i3el4/fhnwtutor` annehmen)
- ein Google-Konto für einen eigenen Gemini-API-Key (den Key von jemand anderem nicht übernehmen)

---

## 1. R und RStudio

Falls noch nicht vorhanden: R installieren, danach RStudio. RStudio einmal öffnen und prüfen, ob die Console eine Version `R version 4.3` oder höher anzeigt.

## 2. Pakete von CRAN

In der RStudio-Console:

```r
install.packages(c("chores", "ellmer", "remotes", "usethis", "gitcreds"))
```

## 3. Zugang zum privaten GitHub-Repo

1. Die Einladung als Collaborator zu [i3el4/fhnwtutor](https://github.com/i3el4/fhnwtutor) annehmen.
2. Ein Token anlegen, sonst schlägt die Installation des privaten Repos fehl:

```r
usethis::create_github_token()
```

Im Browser: Token erzeugen (Recht `repo` reicht), kopieren, das Fenster darf zu.

3. Token in R hinterlegen (einmalig; Windows speichert es im Anmeldeinformationsmanager):

```r
gitcreds::gitcreds_set()
```

Wenn gefragt, das Token einfügen (nicht den GitHub-Login).

## 4. fhnwtutor installieren

```r
remotes::install_github("i3el4/fhnwtutor")
```

Ohne Fehlermeldung ist das Paket in deiner R-Library.

## 5. Eigenen Gemini-Key

1. Unter [Google AI Studio](https://aistudio.google.com/apikey) einen API-Key erzeugen und kopieren.
2. Die Datei für Umgebungsvariablen öffnen:

```r
usethis::edit_r_environ()
```

3. Eine Zeile einfügen, **ohne** Anführungszeichen und **ohne** Leerzeichen um das `=`:

```
GEMINI_API_KEY=hier_den_key_einfuegen
```

4. Speichern, Datei schliessen.

Den Key nicht per Mail oder Chat weitergeben und nicht ins Git-Repo legen.

## 6. chores mit Gemini verbinden

```r
usethis::edit_r_profile()
```

Diese Zeilen ganz einfügen (oder anhängen, falls die Datei schon Inhalt hat):

```r
# fhnwtutor – chores mit Gemini Free Tier
if (interactive()) {
  options(
    chores.chat = ellmer::chat_google_gemini(
      model = "gemini-3-flash-preview",
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

Speichern, Datei schliessen.

## 7. RStudio komplett neu starten

Session → Restart R reicht nicht. RStudio schliessen und wieder öffnen, damit `.Renviron` und `.Rprofile` geladen werden.

Zur Kontrolle in der Console:

```r
"fhnwtutor" %in% loadedNamespaces()
nzchar(Sys.getenv("GEMINI_API_KEY"))
```

Beides soll `TRUE` sein.

## 8. Tastenkürzel (Windows)

1. Tools → Modify Keyboard Shortcuts…
2. Nach `Chores` suchen.
3. `Ctrl+Alt+C` zuweisen.

## 9. Kurz testen

Neues R-Skript, diese Zeile markieren:

```r
wie lade ich meine excel datei hier hinein, damit ich damit arbeiten kann?
```

`Ctrl+Alt+C` drücken und **Umsetzen** anklicken. Die Frage sollte durch R-Code mit `readxl` ersetzt werden.

Die anderen Knöpfe: Kommentieren, Erweitern, Erklären, Bereinigen.

---

## Wenn etwas hakt

| Symptom | Typische Ursache |
|--------|------------------|
| `404` oder `403` bei `install_github` | Einladung nicht angenommen, oder GitHub-Token fehlt / hat kein Recht `repo` |
| Add-in-Liste ohne `umsetzen` | `library(fhnwtutor)` steht nicht in `.Rprofile`, oder RStudio nicht vollständig neu gestartet |
| Fehlermeldung zu API / authentication | `GEMINI_API_KEY` fehlt, Tippfehler in `.Renviron`, oder Key noch nicht gespeichert vor dem Neustart |
| Tastenkürzel macht nichts | Anderes Kürzel belegt `Ctrl+Alt+C`; in den Shortcuts erneut `Chores` suchen |

Nach Prompt-Updates im Repo neu installieren:

```r
remotes::install_github("i3el4/fhnwtutor")
```

Danach RStudio neu starten.

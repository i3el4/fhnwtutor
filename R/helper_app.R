helper_labels <- function() {
  c(
    kommentieren = "Kommentieren",
    erweitern = "Erweitern",
    erklaeren = "Erklären",
    bereinigen = "Bereinigen",
    umsetzen = "Umsetzen"
  )
}

helper_tooltips <- function() {
  c(
    kommentieren = "Markierten Code auf Deutsch kommentieren: Was passiert und warum.",
    erweitern = "Einen naheliegenden nächsten Analyseschritt unter die Auswahl setzen.",
    erklaeren = "Code oder Fehlermeldung ohne Informatik-Jargon erklären.",
    bereinigen = "Base-R in lesbaren tidyverse-Stil mit |> umschreiben.",
    umsetzen = "Eine Anweisung oder Frage durch R-Code ersetzen."
  )
}

helper_app <- function() {
  hide_package_helpers()
  helpers <- getFromNamespace("list_helpers", "chores")()
  labels <- helper_labels()
  tips <- helper_tooltips()
  ordered <- unique(c(intersect(names(labels), helpers), helpers))

  ui <- miniUI::miniPage(
    miniUI::miniContentPanel(
      shiny::div(
        style = "display: flex; flex-direction: column; gap: 8px;",
        shiny::tagList(lapply(ordered, function(chore) {
          label <- if (chore %in% names(labels)) unname(labels[[chore]]) else chore
          tip <- if (chore %in% names(tips)) unname(tips[[chore]]) else label
          shiny::actionButton(
            inputId = paste0("pick_", chore),
            label = label,
            width = "100%",
            title = tip
          )
        }))
      )
    )
  )

  server <- function(input, output, session) {
    lapply(ordered, function(chore) {
      local({
        ch <- chore
        shiny::observeEvent(
          input[[paste0("pick_", ch)]],
          {
            shiny::stopApp(returnValue = paste0(".helper_rs_", ch))
          },
          ignoreInit = TRUE
        )
      })
    })
  }

  viewer <- shiny::dialogViewer("Business Analytics Tutor", width = 280, height = 280)
  shiny::runGadget(ui, server, viewer = viewer)
}

hook_helper_app <- function() {
  if (isTRUE(getOption("fhnwtutor.hooked_helper_app"))) {
    return(invisible())
  }
  ns <- asNamespace("chores")
  unlockBinding(".chores_app", ns)
  assign(".chores_app", helper_app, envir = ns)
  lockBinding(".chores_app", ns)
  options(fhnwtutor.hooked_helper_app = TRUE)
  invisible()
}

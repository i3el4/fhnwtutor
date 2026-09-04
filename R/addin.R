configure_gemini <- function() {
  if (!nzchar(Sys.getenv("GEMINI_API_KEY")) &&
      !nzchar(Sys.getenv("GOOGLE_API_KEY"))) {
    return(invisible())
  }
  if (!is.null(getOption("chores.chat"))) {
    return(invisible())
  }
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
  invisible()
}

run_tutor_addin <- function() {
  configure_gemini()
  if (is.null(getOption("chores.chat"))) {
    stop(
      "Kein Gemini-API-Key gefunden. In der Datei .Renviron eine Zeile GEMINI_API_KEY=... eintragen (ohne Anführungszeichen) und RStudio vollständig neu starten.",
      call. = FALSE
    )
  }
  chores::.init_addin()
}

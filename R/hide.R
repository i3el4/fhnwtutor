hide_package_helpers <- function() {
  remove_helper <- getFromNamespace(".helper_remove", "chores")
  listed <- getFromNamespace("list_helpers", "chores")()
  for (chore in c("cli", "roxygen", "testthat")) {
    if (chore %in% listed) {
      remove_helper(chore)
    }
  }
  invisible()
}

hook_helper_list <- function() {
  if (isTRUE(getOption("fhnwtutor.hooked_helper_list"))) {
    return(invisible())
  }
  suppressMessages(trace(
    "load_chores_directory",
    where = asNamespace("chores"),
    exit = quote(fhnwtutor:::hide_package_helpers()),
    print = FALSE
  ))
  options(fhnwtutor.hooked_helper_list = TRUE)
  invisible()
}

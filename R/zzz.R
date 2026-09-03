# nocov start

.onLoad <- function(libname, pkgname) {
  chores::directory_load(system.file("prompts", package = pkgname))
}

# nocov end

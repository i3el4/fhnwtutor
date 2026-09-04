# nocov start

.onLoad <- function(libname, pkgname) {
  chores::directory_load(system.file("prompts", package = pkgname))
  hook_helper_list()
  hook_helper_app()
  hide_package_helpers()
}

# nocov end

authenticate_steam <- function(key) {
  steamAuth <- list()
  steamAuth$key <- key
  options(steamAuth = steamAuth)
}

is_authenticated <- function() {
  return("key" %in% names(getOption("steamAuth")))
}

auth_key <- function() {
  return(getOption("steamAuth")[["key"]])
}

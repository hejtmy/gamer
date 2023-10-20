#' @import httr2
fetch_data <- function(req) {
  resp <- req_perform(req)
  out <- resp_body_json(resp)
  return(out)
}

#' Fetches list of user games
#'
#' @description The function API is documented [here](https://developer.valvesoftware.com/wiki/Steam_Web_API#GetOwnedGames_.28v0001.29)
get_user_games <- function(steamid, include_appinfo = TRUE,
                           include_played_free_games = TRUE,
                           include_free_sub = TRUE) {
  req <- construct_request("IPlayerService", "GetOwnedGames") %>%
    req_url_query(steamid = steamid, include_appinfo = include_appinfo,
                  include_played_free_games = include_played_free_games,
                  include_free_sub = include_free_sub)
  res <- fetch_data(req)
  return(res)
}

construct_request <- function(interface, command, version = 1) {
  base_url <- "https://api.steampowered.com/"
  if(!is_authenticated()) stop()

  req <- request(base_url) %>%
    req_url_path_append(interface) %>%
    req_url_path_append(command) %>%
    req_url_path_append(str_glue("v{version}")) %>%
    req_url_query(key = auth_key()) %>%
    req_headers("Accept" = "application/json")

  return(req)

}

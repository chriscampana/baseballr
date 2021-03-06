#' Find game_pk values for professional baseball games (major and minor leagues)
#' via the MLB api \url{http://statsapi.mlb.com/api/}
#'
#' @param date The date for which you want to find game_pk values for MLB games
#' @param level_ids A numeric vector with ids for each level where game_pks are
#' desired. See below for a reference of level ids.
#' @importFrom jsonlite fromJSON
#' @return Returns a data frame that includes game_pk values and additional
#' information for games scheduled or played
#' requested
#' @section Level IDs:
#'
#' The following IDs can be passed to the level_ids argument:
#'
#' 1 = MLB
#' 11 = Triple-A
#' 12 = Doubl-A
#' 13 = Class A Advanced
#' 14 = Class A
#' 15 = Class A Short Season
#' 5442 = Rookie Advanced
#' 16 = Rookie
#' 17 = Winter League
#' @keywords MLB, sabermetrics
#' @export
#'
#' @examples \dontrun{get_game_pks_mlb("2019-04-29")}

get_game_pks_mlb <- function(date,
                             level_ids = c(1)) {

  api_call <- paste0("http://statsapi.mlb.com/api/v1/schedule?sportId=", paste(level_ids, collapse = ','), "&date=", date)

  payload <- jsonlite::fromJSON(api_call, flatten = TRUE)

  payload <- payload$dates$games %>%
    as.data.frame() %>%
    rename(game_pk = gamePk)

  return(payload)

}

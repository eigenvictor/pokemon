library(httr)
library(jsonlite)

get_all_pokemon <- function() {
  get_res <- httr::GET("https://pokeapi.co/api/v2/pokemon/")
  
  parsed_res <- parse_json(get_res)
  data <- parsed_res$results
  next_url <- parsed_res$`next`
  
  while(length(data) < parsed_res$count) {
    get_res <- httr::GET(next_url)
    
    parsed_res <- parse_json(get_res)
    data <- c(data, parsed_res$results)
    next_url <- parsed_res$`next`
  }
  
  data
}

query_api <- function(url) {
  get_res <- httr::GET(url)
  parse_json(get_res)
}

get_pokemon_info <- function(pokemon) {
  query_api(pokemon$url)
}

pokemon <- get_all_pokemon()

parsed_res <- query_api(pokemon[[69]][["url"]])

pokemon_info <- 
  lapply(
    X = pokemon, get_pokemon_info
  )

saveRDS(pokemon_info, "data/all_pokemon_info_raw.RDS")


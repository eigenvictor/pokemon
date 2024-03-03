library(dplyr)

pokemon_info <- readRDS(pokemon_info, "data/all_pokemon_info_raw.RDS")

get_types <- function(pokemon) {
  
  type1 = pokemon$types[[1]]$type$name
  type2 = ifelse(length(pokemon$types)==2, pokemon$types[[2]]$type$name, NA_character_)
  
  list(
    type1 = type1,
    type2 = type2
  )
}

get_name <- function(pokemon) {
  pokemon$name
}

get_number <- function(pokemon) {
  pokemon$order
}

pokemon_types <- bind_rows(
  lapply(X = pokemon_info, FUN = get_types)
)

pokemon_data <- data.frame(
  pokedex_number = sapply(X = pokemon_info, FUN = get_number),
  name = sapply(X = pokemon_info, FUN = get_name)
) %>% 
  cbind(pokemon_types)

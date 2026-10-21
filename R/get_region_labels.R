# Assigns labels to a bunch of countries arising from the data
get_region_labels <- function() {
  united_kingdom <- c(
    "uk",
    "u.k.",
    "u.k",
    "united kingdom",
    "great britain",
    "england",
    "scotland",
    "wales",
    "northern ireland"
  )

  europe <- c(
    "germany",
    "switzerland",
    "romania"
  )

  north_america <- c(
    "us",
    "u.s.",
    "u.s",
    "usa",
    "united states",
    "united states of america",
    "america",
    "canada"
  )

  oceania <- "australia"
  europe <- "europe"
  asia <- c("asia", "china", "malaysia", "thailand")
  south_america <- "south america"

  return(list(
    united_kingdom = united_kingdom,
    europe = europe,
    north_america = north_america,
    south_america = south_america,
    oceania = oceania,
    europe = europe,
    asia = asia
  ))
}

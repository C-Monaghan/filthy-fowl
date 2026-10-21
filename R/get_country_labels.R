# Assign labels to a bunch of countries in the data
get_country_labels <- function() {
  # Missing data
  missing_vars <- c(
    "",
    "999",
    "na",
    "n/a",
    "not answered",
    "not applicable",
    "missing",
    "don't know",
    "dont know",
    "prefer not to say"
  )

  # No applicable answers
  no_applic_vars <- c(
    "europe",
    "asia",
    "south america",
    "north america",
    "africa",
    "oceania"
  )

  # Others
  other_vars <- c(
    "other",
    "other country",
    "other country/continent",
    "other (please specify)",
    "other (please list)",
    "other (please list below)"
  )

  # United Kingdom
  uk_vars <- c(
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

  # United States
  usa_vars <- c(
    "us",
    "u.s.",
    "u.s",
    "usa",
    "united states",
    "united states of america",
    "america"
  )

  canada_vars <- c("canada", "can")

  aus_vars <- c("australia", "aus")

  return(
    list(
      uk_vars = uk_vars,
      usa_vars = usa_vars,
      canada_vars = canada_vars,
      aus_vars = aus_vars,
      other_vars = other_vars,
      no_applic_vars = no_applic_vars,
      missing_vars = missing_vars
    )
  )
}

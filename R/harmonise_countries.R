harmonise_countries <- function(data) {
  # First we can specify what each of the countries and regions are ------------
  countries <- get_country_labels()
  regions <- get_region_labels()

  # To address an issue with study 9 (no country column being present)
  if (!"country" %in% colnames(data)) {
    data <- data |> mutate(country = "Canada")
  }

  # Now we will convert the countries to their actual labels (if possible ------
  if (haven::is.labelled(data$country)) {
    data <- data |>
      mutate(country = haven::as_factor(country, levels = "labels"))
  }

  # Then we can tidy up the labels ---------------------------------------------
  data <- data |>
    mutate(
      country = stringr::str_trim(country),
      country = stringr::str_to_lower(country)
    )

  # Now we can assign the region names -----------------------------------------
  data <- data |>
    mutate(
      region = case_when(
        country %in% regions$united_kingdom ~ "United Kingdom",
        country %in% regions$europe ~ "Europe",
        country %in% regions$north_america ~ "North America",
        country %in% regions$south_america ~ "South America",
        country %in% regions$oceania ~ "Oceania",
        country %in% regions$asia ~ "Asia",
        TRUE ~ NA
      )
    )

  # Finally we can add the country labels --------------------------------------
  data <- data |>
    mutate(
      country = case_when(
        country %in% countries$uk_vars ~ "United Kindgom",
        country %in% countries$usa_vars ~ "United States",
        country %in% countries$canada_vars ~ "Canada",
        country %in% countries$aus_vars ~ "Australia",
        country %in% countries$other_vars ~ "Other",
        country %in% countries$no_applic_vars ~ NA,
        country %in% countries$missing_vars ~ NA,
        TRUE ~ NA
      )
    )

  return(data)
}

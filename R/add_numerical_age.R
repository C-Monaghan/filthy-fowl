# Some studies have people with ages as a character column - this fixes it
add_numerical_age <- function(data) {
  if (is.character(data$age)) {
    data <- data |>
      mutate(
        age = stringr::str_trim(age),
        age = stringr::str_extract(age, "[0-9]+"),
        age = as.numeric(age)
      )
  }

  # Filter out participants who are under the age of 18
  data <- data |> filter_out(age < 18)

  return(data)
}

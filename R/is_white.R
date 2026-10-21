# Calculate the percentage of white people in the datasets
is_white <- function(data) {
  # Get the ethnicities
  white_vars <- get_ethnicites()

  if (!"ethnicity" %in% colnames(data)) {
    data <- data |> mutate(ethnicity = NA, is_white = NA)
  } else {
    data <- data |>
      mutate(
        ethnicity = str_to_upper(ethnicity),
        ethnicity = str_trim(ethnicity),
        is_white = case_when(
          ethnicity %in% white_vars ~ TRUE,
          TRUE ~ FALSE
        )
      )
  }

  return(data)
}

list_sav_files <- function(data_path) {
  # Get the associated file
  file <- list.files(data_path, pattern = "\\.sav$", full.names = TRUE)

  # Get the associated study number
  name <- file |> stringr::str_extract(pattern = "study_[0-9]+")

  # Combine into a nice little tibble
  tibble(file = file, study_name = name)
}

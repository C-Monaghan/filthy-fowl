read_data <- function(data_files) {
  # Extract relevant info from object
  file <- data_files$file
  name <- data_files$study_name

  # Get the multidimensional items from the three studies
  if(name == "study_4") {
    fself_items <- c("fself_3", "fself_6", "fself_9")
  } else if(name == "study_9") {
    fself_items <- c("fself_year", "fself_1", "fself_2", "fself_3")
  } else if(name == "study_16") {
    fself_items <- c("fself_3", "fself_8", "fself_13")
  } else {
    fself_items <- NULL
  }

  # Read and process data
  read_sav(file = file) |>
    select(any_of(c(
      "age",
      "gender",
      "country",
      "educat",
      "ethnicity",
      "fsrh",
      "fsc",
      fself_items,
      paste0("wbi_", 1:12)
    ))) |>
    mutate(study_name = name) |>
    relocate(study_name)
}

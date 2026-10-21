#* -----------------------------------------------------------------------------
#* Drop participants with more than 80% missingness acorss the multidimensional
#* FSC items
#* -----------------------------------------------------------------------------
drop_high_fsc_missing <- function(data) {
  # What is the study
  name <- data$study_name |> unique()

  # Get the multidimensional items from the three studies
  if (name == "study_4") {
    fself_items <- c("fself_3", "fself_6", "fself_9")
  } else if (name == "study_9") {
    fself_items <- c("fself_year", "fself_1", "fself_2", "fself_3")
  } else if (name == "study_16") {
    fself_items <- c("fself_3", "fself_8", "fself_13")
  }

  # Only apply this operation to the 3 studies
  if (name %in% c("study_4", "study_9", "study_16")) {
    data <- data |>
      mutate(is_missing = rowMeans(across(all_of(fself_items), is.na))) |>
      filter(is_missing < 0.8) |>
      select(-is_missing)
  } else {
    # Drop missing FSC data in the other single item datasets
    data <- data |> filter_out(is.na(fsc))
  }

  return(data)
}

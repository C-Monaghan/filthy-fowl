#* -----------------------------------------------------------------------------
#*  Calculate mean of the multi dimensional FSC items
#* -----------------------------------------------------------------------------
score_fsc <- function(data) {
  # What is the study
  name <- data$study_name |> unique()

  # Get the multidimensional items from the three studies
  if (name == "study_4") {
    fself_items <- c("fself_3", "fself_6", "fself_9")
  } else if (name == "study_9") {
    fself_items <- c("fself_year", "fself_1", "fself_2", "fself_3")
  } else if (name == "study_16") {
    fself_items <- c("fsc", "fself_3", "fself_8", "fself_13")
  }

  # Keep the orginal FSC item (useful later)
  if (name == "study_16") {
    data <- data |> mutate(fsc_og = fsc)
  }

  # Calculate a mean score
  if (name %in% c("study_4", "study_9", "study_16")) {
    data <- data |>
      mutate(fsc = rowMeans(across(all_of(fself_items)), na.rm = TRUE))
  }

  return(data)
}

# Create a dataset with the moderators of interest for the meta analysis
create_moderators <- function(data) {
  # First highlight if the FSC measure is single item or multi item
  data <- data |>
    mutate(
      fsc_measure = case_when(
        study_name %in% c("study_4", "study_9", "study_16") ~ "multi-item",
        TRUE ~ "single-item"
      )
    )

  # Next highlight if it is a student or community scale
  data <- data |>
    mutate(
      sample = case_when(
        study_name %in% c("study_4", "study_5", "study_9") ~ "student",
        TRUE ~ "community"
      )
    )

  # Next highlight if the study was a lab or external study
  data <- data |>
    mutate(
      is_lab = case_when(
        study_name %in% paste0("study_", 1:21) ~ TRUE,
        TRUE ~ FALSE
      )
    )

  # Then create our moderator statistics
  moderators <- data |>
    summarise(
      study_id = study_name |> unique(),
      n = n(),
      percent_female = sum(is_female, na.rm = TRUE) / n,
      fsc_measure = fsc_measure |> unique(),
      sample = sample |> unique(),
      lab_study = is_lab |> unique(),
      mean_age = mean(age, na.rm = TRUE),
    )

  return(moderators)
}

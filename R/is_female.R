# Figure of if a person in the data is female or not
is_female <- function(data) {
  # These studies have female coded as 1
  female_first_studies <- paste0("study_", c(1, 2, 9, 13))

  data |>
    mutate(
      is_female = case_when(
        study_name %in% female_first_studies & gender == 1 ~ TRUE,
        !study_name %in% female_first_studies & gender == 2 ~ TRUE,
        is.na(gender) ~ NA,
        TRUE ~ FALSE
      )
    )
}

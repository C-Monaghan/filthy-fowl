create_summary_data <- function(data) {
  if (!"fsc" %in% colnames(data)) {
    data <- data |> mutate(fsc = NA)
  }

  data |>
    summarise(
      study = study_name |> unique(),
      n = n(),
      percent_female = sum(is_female, na.rm = TRUE) / n,
      percent_white = sum(is_white, na.rm = TRUE) / n,
      mean_age = mean(age, na.rm = TRUE),
      sd_age = sd(age, na.rm = TRUE),
      mean_wbi = mean(wbi_mean, na.rm = TRUE),
      sd_wbi = sd(wbi_mean, na.rm = TRUE),
      mean_fsc = mean(fsc, na.rm = TRUE),
      sd_fsc = sd(fsc, na.rm = TRUE)
    ) |>
    mutate(study_num = stringr::str_extract(study, "[0-9]+") |> as.integer()) |>
    mutate(study = factor(study, levels = paste0("study_", 1:21))) |>
    relocate(study, study_num)
}

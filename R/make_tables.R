#* -----------------------------------------------------------------------------
#* Make various tables for manuscript
#* -----------------------------------------------------------------------------

#? Function to make demographic table ------------------------------------------
make_tbl_1 <- function(data) {
  # Extract study name and number
  study <- data$study_name |> unique()
  num <- str_extract(study, "[0-9]+")

  # Create Table 1 summary statistics
  tbl_1 <- data |>
    summarise(
      sample = paste0("S", num),
      n = n(),
      percent_female = sum(is_female, na.rm = TRUE) / n,
      percent_white = sum(is_white, na.rm = TRUE) / n,
      mean_age = mean(age, na.rm = TRUE),
      sd_age = sd(age, na.rm = TRUE),
      percent_highschool = mean(education == "High School", na.rm = TRUE),
      percent_college = mean(education == "Undergraduate", na.rm = TRUE),
      percent_postgrad = mean(education == "Postgraduate", na.rm = TRUE)
    ) |>
    mutate(across(
      .cols = where(is.numeric),
      .fns = function(x) round(x, digits = 2)
    ))

  # Arrange studies in Table (1 → 21)
  tbl_1 <- tbl_1 |> mutate(sample = factor(sample, levels = paste0("S", 1:21)))

  return(tbl_1)
}

#? Function to make summary statistics -----------------------------------------
make_tbl_2 <- function(data) {
  # Extract study name and number
  study <- data$study_name |> unique()
  num <- str_extract(study, "[0-9]+")
  n <- nrow(data)

  # Get cronbach alpha values for FSC and WBI
  fsc_alpha <- calculate_cronbach_alpha(data = data, var = "fsc")
  wbi_alpha <- calculate_cronbach_alpha(data = data, var = "wbi")

  # Get the FSRH summary data (if available)
  if ("fsrh" %in% colnames(data)) {
    fsrh_summary <- data |>
      select(fsrh) |>
      summarise(
        mean = mean(fsrh, na.rm = TRUE),
        sd = sd(fsrh, na.rm = TRUE)
      )
  } else {
    fsrh_summary <- NULL
    fsrh_summary$mean <- 0
    fsrh_summary$sd <- 0
  }

  # Table 2 summary
  tbl_2 <- data |>
    summarise(
      # Summary overview
      sample = paste0("S", num, " (", n, ")"),
      # FSC variable
      fsc_alpha = fsc_alpha,
      fsc_mean = mean(fsc, na.rm = TRUE),
      fsc_sd = sd(fsc, na.rm = TRUE),
      # WBI variables
      wbi_alpha = wbi_alpha,
      wbi_mean_2 = mean(wbi_mean, na.rm = TRUE),
      wbi_sd = sd(wbi_mean, na.rm = TRUE),
      # FSRH variable
      fsrh_alpha = 0,
      fsrh_mean = fsrh_summary$mean,
      fsrh_sd = fsrh_summary$sd
    ) |>
    mutate(across(
      .cols = where(is.numeric),
      .fns = function(x) round(x, digits = 2)
    ))

  return(tbl_2)
}

#? Function to make the meta analysis table ------------------------------------
make_tbl_3 <- function(meta_data) {
  tbl_3 <- meta_data |>
    mutate(
      study_id = str_remove(study_id, "tudy_"),
      study_id = str_to_upper(study_id)
    ) |>
    select(
      sample = study_id,
      n = n,
      measure = fsc_measure,
      `FSC-WBI (r)` = fsc_wbi_mean_r,
      `FSC-FSRH (r)` = fsc_fsrh_r,
      `FSRH-WBI (r)` = wbi_mean_fsrh_r,
      `FSC-WBI (Sr)` = fsc_wbi_mean_semi_r
    ) |>
    mutate(across(
      .cols = where(is.numeric),
      .fns = function(x) round(x, digits = 2)
    ))

  # Arrange studies
  tbl_3 <- tbl_3 |> mutate(sample = factor(sample, levels = paste0("S", 1:21)))

  return(tbl_3)
}

# Create a heterogeniety table
create_hetero_table <- function(results) {
  results |>
    as.data.frame() |>
    as.data.frame() |> # Weird that I have to do this twice lol
    rownames_to_column(var = "statistic") |>
    janitor::clean_names() |>
    mutate(
      statistic = case_when(
        str_detect(statistic, "tau") ~ str_replace(statistic, "tau", "\\\\tau"),
        str_detect(statistic, "(%)") ~ str_remove(statistic, "\\(%\\)"),
        TRUE ~ statistic
      )
    ) |>
    transmute(
      Statistic = statistic,
      Result = sprintf("%.2f [%.2f, %.2f]", estimate, ci_lb, ci_ub)
    ) |>
    tt() |>
    style_tt(i = 0, bold = TRUE) |>
    format_tt(j = 1, math = TRUE)
}

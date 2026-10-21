calculate_cronbach_alpha <- function(data, var = c("fsc", "wbi")) {
  # What is the study
  name <- data$study_name |> unique()

  # Get the multidimensional items from the three studies
  if (name == "study_4") {
    fself_items <- c("fself_3", "fself_6", "fself_9")
  } else if (name == "study_9") {
    fself_items <- c("fself_year", "fself_1", "fself_2", "fself_3")
  } else if (name == "study_16") {
    fself_items <- c("fsc_og", "fself_3", "fself_8", "fself_13")
  } else {
    fself_items <- "ignore_me"
  }

  # Get the WBI items
  wbi_items <- paste0("wbi_", 1:12)

  # First calculate the alpha value for the multidimension questions
  if (all(fself_items %in% colnames(data)) & var == "fsc") {
    f_alpha <- data |> select(all_of(fself_items)) |> psych::alpha()

    alpha_val <- f_alpha$total$raw_alpha |> round(digits = 2)
  } else {
    alpha_val <- 0
  }

  # Now get the alpha value for the wbi items
  if (all(wbi_items %in% colnames(data)) & var == "wbi") {
    w_alpha <- data |> select(all_of(wbi_items)) |> psych::alpha()

    alpha_val <- w_alpha$total$raw_alpha |> round(digits = 2)
  }

  return(alpha_val)
}

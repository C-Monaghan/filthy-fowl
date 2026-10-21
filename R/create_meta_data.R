create_meta_data <- function(data) {
  # Get moderator and correlation data
  moderators <- create_moderators(data = data)
  correlations <- calculate_correlations(data = data)

  # Join both correlations and moderators
  meta_data <- left_join(
    correlations,
    moderators,
    by = "study_id"
  ) |>
    relocate(study_id, n)

  # Transform raw correlations into Fisher Z scores and calculate variability
  meta_data <- meta_data |>
    create_fisher_z() |>
    calculate_variability()

  return(meta_data)
}

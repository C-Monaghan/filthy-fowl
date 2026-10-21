# Split the meta data into individual correlations
split_meta_data <- function(meta_data) {
  meta_data |>
    tidyr::pivot_longer(
      cols = c(
        fsc_wbi_mean_r:fsc_wbi_mean_semi_r,
        fsc_wbi_mean_z:fsc_wbi_mean_semi_z
      ),
      names_to = c("correlation", ".value"),
      names_pattern = "(.*)_(r|z)$"
    ) |>
    mutate(
      correlation = stringr::str_remove(correlation, "_r"),
      correlation = factor(
        correlation,
        levels = c(
          "fsc_wbi_mean",
          "fsc_fsrh",
          "wbi_mean_fsrh",
          "fsc_wbi_mean_semi"
        )
      )
    ) |>
    relocate(vi, .after = last_col()) |>
    mutate(
      fsc_measure = factor(
        fsc_measure,
        levels = c("single-item", "multi-item", "experimental")
      ),
      sample = factor(sample, levels = c("community", "student"))
    ) |>
    split(~correlation)
}

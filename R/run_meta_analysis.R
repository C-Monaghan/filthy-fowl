#* -----------------------------------------------------------------------------
#* Run a random effects meta analysis
#* -----------------------------------------------------------------------------
run_meta_analysis <- function(meta_data) {
  meta_data |>
    imap(function(data, correlation) {
      # TODO: Remove once all studies are added
      # if (correlation %in%"fsc_wbi_mean_semi") {
      #   return(NULL)
      # }

      # Arrange the studies nicely
      data <- data |>
        mutate(study_id = factor(study_id, levels = paste0("study_", 1:27))) |>
        arrange(study_id)

      # Fit random effects meta analysis
      rma_fit <- rma(yi = z, vi = vi, data = data)

      # Get confidence intervals for heterogeneity statistics
      conf_int <- confint(rma_fit)

      hetero_tbl <- create_hetero_table(conf_int)

      # Return everything as a nice list object
      return(list(
        data = data,
        model_fit = rma_fit,
        conf_int = conf_int,
        hetero_tbl = hetero_tbl
      ))
    })
}

#* Extract the following correlations from the data
#* 1. FSC → WBI (unadjusted)
#* 2. FSC → FSRH (unadjusted)
#* 3. FSRH → WBI (unadjusted)
#* 4. FSC → WBI (adjusting for FSRH)
#* -----------------------------------------------------------------------------

#? Helper function to calculate semi partial correlation
#? Equation 2.2 of Kim (2015) → doi: 10.5351/CSAM.2015.22.6.665
semi_partial <- function(r_12, r_13, r_23) {
  alpha <- r_12 - (r_13 * r_23)
  beta <- 1 - r_23^2

  alpha / sqrt(beta)
}

calculate_correlations <- function(data) {
  # Some constants
  study_id <- data$study_name |> unique()
  partial_vars <- c("fsc", "fsrh", "wbi_mean")

  #! Temporary code ------------------------------------------------------------
  if (!"fsc" %in% colnames(data)) {
    final_data <- data |>
      summarise(
        study_id = study_id,
        fsc_wbi_mean_r = NA,
        fsc_fsrh_r = NA,
        wbi_mean_fsrh_r = NA,
        fsc_wbi_mean_semi_r = NA
      )

    return(final_data)
  }
  #! ---------------------------------------------------------------------------

  #* First we will get the unadjusted correlations
  if (all(partial_vars %in% colnames(data))) {
    #* Run the correlation between all three variables
    correlation_result <- data |>
      select(fsc, wbi_mean, fsrh) |>
      correlation::correlation(
        method = "pearson",
        use = "pairwise.complete.obs",
        redundant = FALSE,
        p_adjust = "none"
      )

    # Clean and tidy up the results
    correlation_data <- correlation_result |>
      tibble() |>
      janitor::clean_names() |>
      transmute(
        study_id = study_id,
        link = stringr::str_glue("{parameter1}_{parameter2}_r"),
        r = r
      ) |>
      tidyr::pivot_wider(names_from = "link", values_from = "r")

    # Now calculate semi partial correlation removing the variance of
    # FSRH from WBI
    final_data <- correlation_data |>
      mutate(
        fsc_wbi_mean_semi_r = semi_partial(
          r_12 = fsc_wbi_mean_r,
          r_13 = fsc_fsrh_r,
          r_23 = wbi_mean_fsrh_r
        )
      )
  } else {
    #* In this case, only FSC and WBI are present in the data - so we will only
    #* extract 1 correlation and leave the rest as NA
    correlation_result <- data |>
      select(fsc, wbi_mean) |>
      correlation::correlation(
        method = "pearson",
        use = "pairwise.complete.obs",
        redundant = FALSE,
        p_adjust = "none",
      )

    # Extract our correlation result
    correlation_data <- correlation_result |>
      tibble() |>
      janitor::clean_names() |>
      transmute(
        study_id = study_id,
        link = stringr::str_glue("{parameter1}_{parameter2}_r"),
        r = r
      ) |>
      tidyr::pivot_wider(names_from = "link", values_from = "r")

    #* Add in the missing correlations
    final_data <- correlation_data |>
      mutate(
        fsc_fsrh_r = NA,
        wbi_mean_fsrh_r = NA,
        fsc_wbi_mean_semi_r = NA
      )
  }

  # Hopefully return everything in a nice format
  return(final_data)
}

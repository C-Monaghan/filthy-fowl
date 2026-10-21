#* -----------------------------------------------------------------------------
#* Transform the correlations into Fisher Z scores and calculate variability
#* -----------------------------------------------------------------------------

#? Helper function to calculate Fisher Z score
fisher_formula <- function(r) {
  theta <- (1 + r) / (1 - r)

  0.5 * log(theta)
}

#? Helper function to calculate sampling variability
variability <- function(n) {
  1 / (n - 3)
}

#? Function to transform R to Fisher Z (yi from metafor::escalc())
create_fisher_z <- function(meta_data) {
  meta_data |>
    mutate(
      fsc_wbi_mean_z = fisher_formula(r = fsc_wbi_mean_r),
      fsc_fsrh_z = fisher_formula(r = fsc_fsrh_r),
      wbi_mean_fsrh_z = fisher_formula(r = wbi_mean_fsrh_r),
      fsc_wbi_mean_semi_z = fisher_formula(r = fsc_wbi_mean_semi_r),
    )
}

#? Calculate sampling variability (vi from metafor::escalc())
calculate_variability <- function(meta_data) {
  meta_data |> mutate(vi = variability(n = n))
}

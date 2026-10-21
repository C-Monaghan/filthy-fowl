# FSRH shuld be on a 1-5 scale where a higher value is indicative of poorer
# health. However, some studies have FSRH on a 0 - 100 scale. This scale is
# collapsed to a 1 - 5 scale by splitting it into groups of 20
process_fsrh <- function(data) {
  if ("fsrh" %in% colnames(data)) {
    # All the labelled data is between 1 - 5
    if (is.labelled(data$fsrh)) {
      data <- data |>
        mutate(
          fsrh = case_when(
            fsrh %in% c(1:5) ~ fsrh,
            TRUE ~ NA
          )
        )
    } else {
      data <- data |>
        mutate(
          fsrh = case_when(
            fsrh <= 20 ~ 5,
            fsrh <= 40 ~ 4,
            fsrh <= 60 ~ 3,
            fsrh <= 80 ~ 2,
            fsrh <= 100 ~ 1,
            TRUE ~ NA
          )
        )
    }

    # Now reverse score the items ----------------------------------------------
    data <- data |> mutate(fsrh = 6 - fsrh)
  }

  return(data)
}

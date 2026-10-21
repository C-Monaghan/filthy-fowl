initial_process <- function(data) {
  # All the items with missing data numbers (999, -999, etc.)
  study_items <- c(
    "age",
    "gender",
    "educat",
    "fsc",
    "fsrh",
    paste0("fself_", c(1, 2, 3, 6, 8, 9, 13)),
    "fself_year",
    paste0("wbi_", 1:12)
  )

  # Convert those values to missing
  data |>
    mutate(across(
      .cols = any_of(study_items),
      .fns = function(item) {
        case_when(
          item %in% c(0, 999) ~ NA,
          TRUE ~ item
        )
      }
    ))
}

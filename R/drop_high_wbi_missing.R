# Remove people with more than 80% missing data in the WBI items
drop_high_wbi_missing <- function(data) {
  wbi_vars <- paste0("wbi_", 1:12)

  data |>
    mutate(is_missing = rowMeans(across(all_of(wbi_vars), is.na))) |>
    filter(is_missing < 0.8) |>
    select(-is_missing)
}

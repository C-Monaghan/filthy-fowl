# Reverse code two items from the Wellness Inventory Behaviour
reverse_wbi <- function(data) {
  data |>
    mutate(
      wbi_3 = case_when(wbi_3 %in% c(1:5) ~ 6 - wbi_3, TRUE ~ NA),
      wbi_10 = case_when(wbi_10 %in% c(1:5) ~ 6 - wbi_10, TRUE ~ NA)
    )
}

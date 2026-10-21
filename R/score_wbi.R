# Calculate a mean for the Wellness Behaviour Inventory
#! Items 9 and 12 are not included in the scoring
score_wbi <- function(data) {
  data |> mutate(wbi_mean = rowMeans(across(c(wbi_1:wbi_8, wbi_10, wbi_11))))
}

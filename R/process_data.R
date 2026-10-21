# Process the individual raw datasets before collapsing them all togther.
# This processing includes
# - Collapsing the education variable into three levels
# - Flagging if a participant in female
# - Flagging if a participant is white
# - Create consistent country and region labels
# - Reverse score items from the Wellness Behaviour Inventory (3 & 10)
process_data <- function(raw_data) {
  # Run processing functions
  process_data <- raw_data |>
    initial_process() |>
    add_numerical_age() |>
    collapse_education() |>
    is_female() |>
    is_white() |>
    harmonise_countries() |>
    process_fsrh() |>
    reverse_wbi() |>
    drop_high_wbi_missing() |>
    score_wbi() |>
    drop_high_fsc_missing() |>
    score_fsc() |>
    zap_labels()

  return(process_data)
}

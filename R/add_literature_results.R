add_literature_results <- function(meta_data) {
  literature <- load_literature_data()

  bind_rows(meta_data, literature)
}

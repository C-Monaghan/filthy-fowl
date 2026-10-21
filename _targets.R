#* -----------------------------------------------------------------------------
#* Targets pipline for meta analysis of FSC and health behaviours
#* Author: Cormac Monaghan
#* Last modified: 2026-08-23
#* -----------------------------------------------------------------------------

# Load all necessary packages
source("packages.R")

# Load all necessary functions
tar_source(files = "R/")

# Global options to be throughout pipeline
tar_option_set(
  format = "qs",
  garbage_collection = TRUE
)

# Targets pipeline
list(
  #? ---------------------------------------------------------------------------
  #? Reading in various file names and associated data
  #? ---------------------------------------------------------------------------
  tar_target(
    name = data_files,
    command = list_sav_files(data_path = here::here("data/raw/"))
  ),

  tar_target(
    name = raw_data,
    command = read_data(data_files = data_files),
    pattern = map(data_files),
    iteration = "list"
  ),

  #? ---------------------------------------------------------------------------
  #? Process the data
  #? ---------------------------------------------------------------------------
  tar_target(
    name = processed_data,
    command = process_data(raw_data = raw_data),
    pattern = map(raw_data),
    iteration = "list"
  ),

  #? ---------------------------------------------------------------------------
  #? Create data needed for meta analysis
  #? ---------------------------------------------------------------------------
  tar_target(
    name = meta_data,
    command = create_meta_data(data = processed_data),
    pattern = map(processed_data)
  ),

  #? ---------------------------------------------------------------------------
  #? Add the outside literature
  #? ---------------------------------------------------------------------------
  tar_target(
    name = meta_data_full,
    command = add_literature_results(meta_data = meta_data)
  ),

  tar_target(
    name = meta_data_split,
    command = split_meta_data(meta_data = meta_data_full)
  ),

  tar_target(
    name = meta_analysis,
    command = run_meta_analysis(meta_data = meta_data_split)
  ),

  #? ---------------------------------------------------------------------------
  #? Create various tables for manuscript
  #? ---------------------------------------------------------------------------
  tar_target(
    name = table_1,
    command = make_tbl_1(data = processed_data),
    pattern = map(processed_data)
  ),

  tar_target(
    name = table_2,
    command = make_tbl_2(data = processed_data),
    pattern = map(processed_data)
  ),

  tar_target(
    name = table_3,
    command = make_tbl_3(meta_data = meta_data)
  ),

  #? ---------------------------------------------------------------------------
  #? Render Quarto documents
  #? ---------------------------------------------------------------------------
  tar_quarto(
    name = website,
    path = ".",
    quiet = FALSE
  )
)

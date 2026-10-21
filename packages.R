# Required packages for targets pipeline
packages <- c(
  # The usual gang
  "dplyr",
  "tibble",
  "stringr",
  "purrr",
  "here",
  "tinytable",

  # Not the usual gang
  "haven",
  "psych",

  # For correlations
  "correlation",

  # For running meta analysis
  "metafor",
  "weightr",

  # For targets
  "targets",
  "tarchetypes"
)

# If package is not installed then install the package
for (package in packages) {
  if (!requireNamespace(package, quietly = TRUE)) {
    install.packages(package)
  }

  library(package, character.only = TRUE)
}

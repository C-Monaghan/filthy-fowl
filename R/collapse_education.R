# Collapse the education variable into three levels
# One thing to note is that not all studies use the same classiciations as
# education - so we will apply some conditional checks in the case_when()
# function
collapse_education <- function(data) {
  data |>
    mutate(
      education = case_when(
        # Dealing with the edge cases first
        study_name == "study_18" & educat %in% c(1:3) ~ "Undergraduate",
        study_name == "study_18" & educat %in% c(4:7) ~ "Postgraduate",
        study_name == "study_20" & educat %in% c(1:4) ~ "Undergraduate",
        study_name == "study_20" & educat == 5 ~ "Postgraduate",

        # Every other study uses the same classiciation
        educat %in% c(1, 2) ~ "High School",
        educat %in% c(3, 4) ~ "Undergraduate",
        educat %in% c(5, 6) ~ "Postgraduate",
        TRUE ~ NA
      )
    )
}

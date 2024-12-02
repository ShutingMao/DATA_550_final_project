here::i_am("code/00_clean_data.R")

library(labelled)
library(gtsummary)
library(openxlsx)
absolute_path_to_data <- here::here("Data 550.xlsx")
data <- read.xlsx(absolute_path_to_data, startRow = 1, colNames = TRUE, detectDates = TRUE)
saveRDS(
  data, 
  file = here::here("derived_data/data_clean.rds")
)

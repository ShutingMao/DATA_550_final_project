here::i_am("code/01_make_table1.R")

data <- readRDS(
  file = here::here("derived_data/data_clean.rds")
)

library(gtsummary)

# Gender 
gender_table <- table(data$`pediatric=1,.adult=2`, data$`sex.M=0,.F=1` == 1)
gender_prop <- prop.table(gender_table)
gender_chisq <- chisq.test(gender_table)

# Non-white
data <- data %>%
  mutate(race_group = ifelse(data$`race.white=1,.Black=2,.Hispanic.=.3,.asian.=4,.other.=5` == 1, "white", "non-white"))
race_table <- table(data$`pediatric=1,.adult=2`, data$race_group)
race_prop <- prop.table(race_table)
race_chisq <- chisq.test(race_table)

# Age at Diagnosis
data$ageatdx <- data$ageatdx / 12  
mean_age_group1 <- mean(data$ageatdx[data$`pediatric=1,.adult=2` == 1], na.rm = TRUE)
mean_age_group2 <- mean(data$ageatdx[data$`pediatric=1,.adult=2` == 2], na.rm = TRUE)
var_age_group1 <- sd(data$ageatdx[data$`pediatric=1,.adult=2` == 1], na.rm = TRUE)
var_age_group2 <- sd(data$ageatdx[data$`pediatric=1,.adult=2` == 2], na.rm = TRUE)
age_t_test <- t.test(data$ageatdx[data$`pediatric=1,.adult=2` == 1], data$ageatdx[data$`pediatric=1,.adult=2` == 2])


table_data <- data.frame(
  Variable = c(
    paste0("Female (", sum(data$`sex.M=0,.F=1` == 1), ", ", round(mean(data$`sex.M=0,.F=1` == 1) * 100, 1), "%)"),
    paste0("Non-White (", sum(data$race_group == "non-white"), ", ", round(mean(data$race_group == "non-white") * 100, 1), "%)"),
    paste0("Age at Diagnosis (years) (", round(mean(data$ageatdx), 1), " ± ", round(sd(data$ageatdx), 1), ")")
  ),
  Pediatric = c(
    paste0(gender_table[1, 2], " (", round(gender_prop[1, 2] * 100, 1), "%)"),
    paste0(race_table[1, 2], " (", round(race_prop[1, 2] * 100, 1), "%)"),
    
    paste0(round(mean_age_group1, 2), " ± ", round(var_age_group1, 2))
  ),
  Adult = c(
    paste0(gender_table[2, 2], " (", round(gender_prop[2, 2] * 100, 1), "%)"),
    paste0(race_table[2, 2], " (", round(race_prop[2, 2] * 100, 1), "%)"),
    
    paste0(round(mean_age_group2, 2), " ± ", round(var_age_group2, 2))
  ),
  P_value = c(
    round(gender_chisq$p.value, 3),
    round(race_chisq$p.value, 3),
    
    round(age_t_test$p.value, 3)
  ),
  Statistical_test_used = c(
    "Chi-squared test", "Chi-squared test",  "Two-sample t-test"
  )
)

table_one<-kbl(table_data, caption = "Demographics by Pediatric and Adult Group") %>%
  kable_classic(full_width = F, html_font = "Cambria") %>%
  add_header_above(c(" " = 1, "Group" = 2, "P-value" = 1, "Statistical test used" = 1)) %>%
  column_spec(1:5, bold = TRUE) %>%
  footnote(general = "Values are presented as n (%) or mean ± SD.")


saveRDS(
  table_one,
  file = here::here("table/table_one.rds")
)
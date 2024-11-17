here::i_am("code/02_make_scatter.R")

data <- readRDS(
  file = here::here("derived_data/data_clean.rds")
)

library(ggplot2)
library(dplyr)
library(tidyr)
# Group and summarize tumor locations by pediatric and adult groups
tumor_counts <- data %>%
  group_by(tumor_location = data$`tumorlocation.1=posterior.fossa,.2=brainstem,.3=cerebral.cortex,.4=suprasellar,.5=optic.nerve`, 
           group = data$`pediatric=1,.adult=2`) %>%
  summarise(Count = n(), .groups = 'drop') %>%  # drop the grouping after summarise
  mutate(Group = ifelse(group == 1, "Pediatric", "Adult"))  # Mutate based on the grouped output

# Pivot the data to a wider format for easier plotting with ggplot2
data_long <- tumor_counts %>%
  pivot_wider(names_from = Group, values_from = Count, values_fill = 0)

# Pivot back to a longer format for ggplot2 plotting
data_long <- data_long %>%
  pivot_longer(cols = c(Pediatric, Adult), names_to = "Group", values_to = "Count")

# Modify the labels to be more descriptive
data_long <- data_long %>%
  mutate(tumor_location = recode(tumor_location, 
                                 `1` = "Posterior Fossa", 
                                 `2` = "Brainstem", 
                                 `3` = "Cerebral Cortex", 
                                 `4` = "Suprasellar", 
                                 `5` = "Optic Nerve"))

# Create the bar chart with updated labels
scatterplot<-ggplot(data_long, aes(x = tumor_location, y = Count, fill = Group)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Tumor Location Distribution by Group",
       x = "Tumor Location",
       y = "Count",
       fill = "Group") +
  theme_minimal(base_size = 15) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(
  here::here("figure/scatterplot.png"),
  plot = scatterplot,
  device = "png"
)



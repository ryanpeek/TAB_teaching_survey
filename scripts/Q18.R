# Make plots for Survey: Q18


# LOAD LIBRARIES ----------------------------------------------------------
library(tidyverse)
library(viridis)

# LOAD DATA ---------------------------------------------------------------

df <- read_csv("data/Q18.csv")

# WRANGLE DATA ------------------------------------------------------------

# select just the cols of interest:
df <- select(df, Class, Categories, ends_with("_score")) 

head(df)

# tidy
df_long<- gather(df, key = score, value = value, NI_score:E_score)
head(df_long)


# PLOT --------------------------------------------------------------------

ggplot(df_long, aes(x=Categories, y=value, fill=score)) + 
  geom_bar(stat="identity", position="dodge") +
  theme_bw() + scale_fill_viridis(direction = -1,discrete = T, option = "D", labels = c("Not Important", "Somewhat Important", "Important", "Extremely Important")) + 
  facet_wrap(~Class) + coord_flip() +
  labs(subtitle="Q18: Thinking about the qualities of a good professor, \n how would you rank the following in order of importance?", fill="Rank", x="", y="Responses")

ggsave(filename = "figs/Q18_grad_vs_faculty.png", width = 7, height = 4, dpi = 400)

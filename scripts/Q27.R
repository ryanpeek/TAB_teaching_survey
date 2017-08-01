# Make plots for Survey: Q27

library(tidyverse)
library(viridis)


# GET DATA ----------------------------------------------------------------

df <- read_csv("data/Q27.csv")


# WRANGLE -----------------------------------------------------------------

# select just the cols of interest:
df <- select(df, Class, Categories, ends_with("_score")) 

# tidy
df_long<- gather(df, key = score, value = value, R1_score:R5_score)
head(df_long)

# make faculty/Grad student data:
facgrad <- df_long %>% filter(Class=="Graduate Student" | Class=="Faculty Member")

# make gender data:
genderdat <- df_long %>% filter(Class=="Female" | Class=="Male")

# PLOTS -------------------------------------------------------------------


ggplot(facgrad, aes(x=Categories, y=value, fill=score)) + 
  geom_bar(stat="identity", position="dodge") +
  theme_bw() + scale_fill_viridis(discrete = T, option = "D", labels = c("1", "2", "3", "4", "5")) + 
  facet_wrap(~Class) + coord_flip() +
  labs(subtitle="Q27: How would you rank the following criteria \n in order of importance for making the best class?", fill="Rank", x="", y="Responses")

ggsave(filename = "figs/Q27_grad_vs_faculty.png", width = 7, height = 4, dpi = 400)


ggplot(genderdat, aes(x=Categories, y=value, fill=score)) + 
  geom_bar(stat="identity", position="dodge") +
  theme_bw() + scale_fill_viridis(discrete = T, option = "D", labels = c("1", "2", "3", "4", "5")) + 
  facet_wrap(~Class) + coord_flip() +
  labs(subtitle="Q27: How would you rank the following criteria \n in order of importance for making the best class?", fill="Rank", x="", y="Responses")

ggsave(filename = "figs/Q27_female_vs_male.png", width = 7, height = 4, dpi = 400)

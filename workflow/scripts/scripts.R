library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

filename <- "."

df <- read_csv(filename, col_names = T)
df_unique <- df %>% group_by(doi) %>% top_n(1) %>% ungroup()

df_unique %>%
  ggplot(aes(x = badges, fill=conference)) +
  geom_bar() +
  ggtitle("Distribution of the number of badges per paper") +
  xlab("Number of badges")

df %>%
  filter(repo_url) %>%
  ggplot(aes(x = sw_env_method, fill = conference)) +
  geom_bar() + 
  theme(axis.text.x = element_text(angle = 45, hjust=1))


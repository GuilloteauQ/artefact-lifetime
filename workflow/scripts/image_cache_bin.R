library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom", strip.background = element_blank()))


args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

plot <- read_csv(filename, col_names = T) %>%
  filter(techno != "none") %>%
  select(doi, conference, bin_cache, bin_cache_long_term, recipe_in_repo) %>%
  rename(
    "Image in binary cache?" = bin_cache,
    "Long-term binary cache?" = bin_cache_long_term,
    "Image recipe available?" = recipe_in_repo
  ) %>%
  pivot_longer(cols=3:5, names_to="type", values_to="value") %>%
  ggplot(aes(x = value, fill = conference)) +
  geom_bar() +
  facet_wrap(~type, ncol=3) +
  xlab("") +
  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
  theme(axis.text.x = element_text(angle = 45, hjust=1))

ggsave(plot = plot, outfile, width=6, height=6)

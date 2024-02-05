library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom", strip.background = element_blank()))


args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df <- read_csv(filename, col_names = T) %>%
  filter(techno != "none") %>%
  select(doi, conference, bin_cache, bin_cache_long_term, recipe_in_repo) %>%
  mutate(long_term_safe = recipe_in_repo | bin_cache_long_term) %>%
  rename(
    "Image in binary cache?" = bin_cache,
    "Long-term binary cache?" = bin_cache_long_term,
    "Image recipe available?" = recipe_in_repo,
    "Long-term binary cache or recipe" = long_term_safe
  ) %>%
  pivot_longer(cols=3:6, names_to="type", values_to="value")

total_papers <- df %>%
  pull(doi) %>%
  unique() %>%
  length()

plot <- df %>%
  mutate(type = factor(type, levels = c("Image in binary cache?", "Long-term binary cache?", "Image recipe available?", "Long-term binary cache or recipe"))) %>%
  mutate(value = factor(value, levels = c("FALSE", "TRUE"))) %>%
  ggplot(aes(x = value)) +
  geom_bar(aes(fill = conference)) +
  geom_text(data = . %>% group_by(type, value) %>% summarize(n = n(), percentage = 100 * n() / total_papers),
            aes(y = n + 5, label = paste(round(percentage, 1), "%", sep="")),
            size = 4) +
  ylab("Number of papers") +
  facet_wrap(~type, ncol=2) +
  xlab("") +
  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
  coord_flip()

ggsave(plot = plot, outfile, width=6, height=4)

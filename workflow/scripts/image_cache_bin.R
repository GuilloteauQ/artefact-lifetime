library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom", strip.background = element_blank()))


args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df <- read_csv(filename, col_names = T) %>%
  filter(techno != "none") %>%
  select(doi, conference, bin_cache, bin_cache_long_term, recipe_in_repo) %>%
  rename(
    "Image in binary cache?" = bin_cache,
    "Long-term binary cache?" = bin_cache_long_term,
    "Image recipe available?" = recipe_in_repo
  ) %>%
  pivot_longer(cols=3:5, names_to="type", values_to="value")

total_papers <- df %>%
  pull(doi) %>%
  unique() %>%
  length()

plot <- df %>%
  mutate(type = factor(type, levels = c("Image in binary cache?", "Long-term binary cache?", "Image recipe available?"))) %>%
  mutate(value = factor(value, levels = c("FALSE", "TRUE"))) %>%
  ggplot(aes(x = value)) +
  geom_bar(aes(fill = conference)) +
  geom_text(data = . %>% group_by(type, value) %>% summarize(n = n(), percentage = 100 * n() / total_papers),
            aes(y = n + 2, label = paste(round(percentage, 1), "%", sep="")),
            size = 4) +
  ylab("Number of papers") +
  facet_wrap(~type, ncol=1) +
  xlab("") +
  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
  coord_flip()

ggsave(plot = plot, outfile, width=6, height=5)

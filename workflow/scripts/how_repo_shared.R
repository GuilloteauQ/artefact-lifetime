library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df <- read_csv(filename, col_names = T) %>%
  filter(repo_url) %>%
  filter(how_shared != "NA") %>%
  mutate(how_shared = if_else(how_shared == "anonymous4openscience+cloud", "a4os+cloud", how_shared)) %>% # using abbreviation
  mutate(how_shared = if_else(how_shared == "anonymous4openscience", "a4os", how_shared))

total_papers <- df %>%
  pull(doi) %>%
  unique() %>%
  length()

plot <- df %>%
  mutate(how_shared = fct_infreq(how_shared)) %>%
  ggplot(aes(x = how_shared)) +
  geom_bar(aes(fill = conference)) +
  geom_text(data = . %>% group_by(how_shared) %>% summarize(n = n(), percentage = 100 * n() / total_papers),
            aes(y = n + 5, label = paste(round(percentage, 1), "%", sep="")),
            size = 4.5) +
  ylab("Number of papers") +
  xlab("") +
  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
  ggtitle("How was the repository shared?") +
  coord_flip()
  #theme(axis.text.x = element_text(angle = 45, hjust=1))

ggsave(plot = plot, outfile, width=6, height=5)

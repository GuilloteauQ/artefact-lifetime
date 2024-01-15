library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

plot <- read_csv(filename, col_names = T) %>%
  filter(repo_url) %>%
  ggplot(aes(x = how_shared, fill = conference)) +
  geom_bar() +
  xlab("") +
  ggtitle("How was the repository shared?")

ggsave(plot = plot, outfile, width=6, height=6)

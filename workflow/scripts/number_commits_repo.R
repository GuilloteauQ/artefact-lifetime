library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

plot <- read_csv(filename, col_names = T) %>%
  filter(repo_url) %>%
  ggplot(aes(x = nb_commits_repo)) +
  stat_ecdf() +
  scale_x_log10("Number of commits in the repositories") +
  ylab("Proportion")

ggsave(plot = plot, outfile, width=6, height=4)

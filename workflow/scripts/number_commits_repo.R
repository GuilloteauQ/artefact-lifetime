library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

plot <- read_csv(filename, col_names = T) %>%
  filter(repo_url) %>%
  ggplot(aes(x = nb_commits_repo, fill = conference)) +
  geom_histogram() +
  xlab("") +
  ggtitle("Number of commits in the repositories")

ggsave(plot = plot, outfile, width=6, height=6)

library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

plot <- read_csv(filename, col_names = T) %>%
  filter(repo_url & how_shared == "git") %>%
  ggplot(aes(x = pinned_version, fill = conference)) +
  geom_bar() +
  xlab("") +
  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
  ggtitle("When shared with only `git`, was the commit used fixed?")

ggsave(plot = plot, outfile, width=6, height=6)

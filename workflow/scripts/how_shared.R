library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

plot <- read_csv(filename, col_names = T) %>%
  filter(repo_url) %>%
  ggplot(aes(x = techno, fill = conference)) +
  geom_bar() +
  xlab("") +
  ggtitle("Technology used to share the software environment")

ggsave(plot = plot, outfile, width=6, height=6)

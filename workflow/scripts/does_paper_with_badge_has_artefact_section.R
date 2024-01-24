library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

plot <- read_csv(filename, col_names = T) %>%
  filter(badges > 0) %>%
  ggplot(aes(x = artefact_section, fill = conference)) +
  geom_bar() +
  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
  ggtitle("Does a paper with at least one badge has the `Artifact` section?") +
  xlab("")

ggsave(plot = plot, outfile, width=6, height=6)

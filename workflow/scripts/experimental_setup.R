library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

plot <- read_csv(filename, col_names = T) %>%
  ggplot(aes(x = experimental_setup, fill = conference)) +
  geom_bar() +
  ggtitle("Experimental setup used") +
  xlab("")

ggsave(plot = plot, outfile, width=6, height=6)

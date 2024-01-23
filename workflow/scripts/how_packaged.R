library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

plot <- read_csv(filename, col_names = T) %>%
  mutate(techno = fct_infreq(techno)) %>%
  ggplot(aes(x = techno, fill = conference)) +
  geom_bar() +
  xlab("") +
  ggtitle("What was the tool used to generate the environment?") +
  theme(axis.text.x = element_text(angle = 45, hjust=1))

ggsave(plot = plot, outfile, width=6, height=6)

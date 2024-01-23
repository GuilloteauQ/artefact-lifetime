library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

plot <- read_csv(filename, col_names = T) %>%
  filter(repo_url) %>%
  filter(how_shared != "NA") %>%
  mutate(how_shared = fct_infreq(how_shared)) %>%
  ggplot(aes(x = how_shared, fill = conference)) +
  geom_bar() +
  xlab("") +
  ggtitle("How was the repository shared?") +
  theme(axis.text.x = element_text(angle = 45, hjust=1))

ggsave(plot = plot, outfile, width=6, height=6)

library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df <- read_csv(filename, col_names = T) %>%
  separate_longer_delim(experimental_setup, "+") %>%
  filter(experimental_setup != "NA")

total_papers <- df %>%
  pull(doi) %>%
  unique() %>%
  length()

plot <- df %>%
  mutate(experimental_setup = fct_infreq(experimental_setup)) %>%
  ggplot(aes(x = experimental_setup)) +
  geom_bar(aes(fill = conference)) +
  geom_text(data = . %>% group_by(experimental_setup) %>% summarize(n = n(), percentage = 100 * n() / total_papers),
            aes(y = n + 11, label = paste(round(percentage, 1), "%", sep="")),
            size = 4) +
  ylab("Number of papers") +
  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
  ggtitle("Experimental setup used") +
  xlab("") +
  coord_flip()

ggsave(plot = plot, outfile, width=6, height=5)

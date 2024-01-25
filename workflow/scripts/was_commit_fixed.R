library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df <- read_csv(filename, col_names = T) %>%
  filter(repo_url & how_shared == "git")

total_papers <- df %>%
  pull(doi) %>%
  unique() %>%
  length()

plot <- df %>%
  ggplot(aes(x = pinned_version)) +
  geom_bar(aes(fill = conference)) +
  geom_text(data = . %>% group_by(pinned_version) %>% summarize(n = n(), percentage = 100 * n() / total_papers),
            aes(y = n + 2, label = paste(round(percentage, 1), "%", sep="")),
            size = 4) +
  ylab("Number of papers") +
  xlab("") +
  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
  ggtitle("When shared with only `git`, was the commit used fixed?")

ggsave(plot = plot, outfile, width=6, height=6)

library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df <- read_csv(filename, col_names = T) %>%
  filter(badges > 0)

total_papers <- df %>%
  pull(doi) %>%
  unique() %>%
  length()

plot <- df %>%
  ggplot(aes(x = artefact_section)) +
  geom_bar(aes(fill = conference)) +
  geom_text(data = . %>% group_by(artefact_section) %>% summarize(n = n(), percentage = 100 * n() / total_papers),
            aes(y = n + 5, label = paste(round(percentage, 1), "%", sep="")),
            size = 4) +
  ylab("Number of papers") +
  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
  ggtitle("Does a paper with at least one badge has the `Artifact` section?") +
  xlab("")

ggsave(plot = plot, outfile, width=6, height=6)

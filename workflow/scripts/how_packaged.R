library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df <- read_csv(filename, col_names = T)

total_papers <- df %>%
  pull(doi) %>%
  unique() %>%
  length()

plot <- df %>%
  mutate(techno = fct_infreq(techno)) %>%
  ggplot(aes(x = techno)) +
  geom_bar(aes(fill = conference)) +
  geom_text(data = . %>% group_by(techno) %>% summarize(n = n(), percentage = 100 * n() / total_papers),
            aes(y = n + 5, label = paste(round(percentage, 2), "%", sep="")),
            size = 4) +
  ylab("Count") +
  xlab("") +
  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
  ggtitle("What was the tool used to generate the environment?") +
  theme(axis.text.x = element_text(angle = 45, hjust=1))

ggsave(plot = plot, outfile, width=6, height=6)
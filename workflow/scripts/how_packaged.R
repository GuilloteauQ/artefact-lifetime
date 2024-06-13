library(tidyverse)
#theme_set(theme_bw() + theme(legend.position = "bottom"))
theme_set(theme_bw() + theme(legend.position = c(0.72, 0.82),
                             legend.title = element_text(size = 8),
                             legend.text = element_text(size = 7),
                             legend.background=element_blank(),
                             legend.key.size = unit(0.4, 'cm')))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df <- read_csv(filename, col_names = T) %>%
  filter(repo_url & !dead_url)

total_papers <- df %>%
  pull(doi) %>%
  unique() %>%
  length()

plot <- df %>%
  mutate(techno = fct_infreq(techno)) %>%
  ggplot(aes(x = techno)) +
  geom_bar(aes(fill = conference)) +
  geom_text(data = . %>% group_by(techno) %>% summarize(n = n(), percentage = 100 * n() / total_papers),
            aes(y = n + 15, label = paste(round(percentage, 1), "%", sep="")),
            size = 4) +
  ylab("Number of artifacts") +
  xlab("") +
  ylim(0, 145) +
  scale_fill_grey("2023 Conferences", start = 0.2, end = 0.8)+
  guides(fill = guide_legend(nrow = 2, byrow=TRUE)) +
  #ggtitle("What was the tool used to generate the environment?") +
  coord_flip()

ggsave(plot = plot, outfile, width=5, height=2.5)

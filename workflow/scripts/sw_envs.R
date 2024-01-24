library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))


args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df <- read_csv(filename, col_names = T) %>%
  filter(repo_url) %>%
  filter(sw_env_method != "container" & sw_env_method != "vm") %>% # because it is actually taken care of in the "techno" column
  mutate(sw_env_method = if_else(sw_env_method == "modules", "module", sw_env_method)) # because of a typo in the data....

total_papers <- df %>%
  pull(doi) %>%
  unique() %>%
  length()

plot <- df %>%
  mutate(sw_env_method = fct_infreq(sw_env_method)) %>%
  ggplot(aes(x = sw_env_method)) +
  geom_bar(aes(fill = conference)) +
  geom_text(data = . %>% group_by(sw_env_method) %>% summarize(n = n(), percentage = 100 * n() / total_papers),
            aes(y = n + 2, label = paste(round(percentage, 2), "%", sep="")),
            size = 2) +
  ylab("Count") +
  xlab("") +
  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
  theme(axis.text.x = element_text(angle = 45, hjust=1))

ggsave(plot = plot, outfile, width=6, height=6)

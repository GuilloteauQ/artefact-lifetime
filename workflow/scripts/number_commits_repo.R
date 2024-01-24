library(tidyverse)
library(geomtextpath)
theme_set(theme_bw() + theme(legend.position = "bottom"))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df <- read_csv(filename, col_names = T) %>%
  filter(repo_url) %>%
  filter(nb_commits_repo > 0)

quantiles <- c(0.25, 0.5, 0.75)
nb_commits_quantiles <- tibble(
  percentage = quantiles,
  q = df %>%
    pull(nb_commits_repo) %>%
    quantile(probs = quantiles) %>%
    unname()
)

plot <- df %>%
  ggplot(aes(x = nb_commits_repo)) +
  stat_ecdf() +
  geom_textvline(data = nb_commits_quantiles, aes(xintercept = q, label = paste(q," (", percentage*100, "%)",sep="")), linetype = "dashed", hjust=0.95) +
  scale_x_log10("Number of commits in the repositories (log scale)") +
  ylab("Proportion")

ggsave(plot = plot, outfile, width=6, height=4)

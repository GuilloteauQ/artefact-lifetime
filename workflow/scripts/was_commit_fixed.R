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

#plot <- df %>%
#  mutate(
#    has_badge = if_else(badges != 0, "Paper has at least one badge", "Paper has no badge")
#  ) %>%
#  mutate(
#    has_badge = factor(has_badge, levels = c("Paper has no badge", "Paper has at least one badge")),
#    pinned_version = factor(pinned_version, levels = c("TRUE", "FALSE"))
#  ) %>%
#  ggplot(aes(x = pinned_version)) +
#  geom_bar(aes(fill = conference)) +
#  ylab("Number of papers") +
#  facet_wrap(~has_badge, ncol=2) +
#  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
#  xlab("Was the commit fixed when only using git?") +
#  guides(fill = guide_legend(nrow = 2, byrow=TRUE)) +
#  theme(strip.background = element_blank())

ggsave(plot = plot, outfile, width=4, height=4)

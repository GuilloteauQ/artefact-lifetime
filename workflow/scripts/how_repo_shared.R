library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom", strip.background = element_blank()))

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df <- read_csv(filename, col_names = T) %>%
  filter(repo_url) %>%
  filter(how_shared != "NA") %>%
  mutate(how_shared = if_else(how_shared == "anonymous4openscience+cloud", "a4os+cloud", how_shared)) %>% # using abbreviation
  mutate(how_shared = if_else(how_shared == "anonymous4openscience", "a4os", how_shared)) %>%
  mutate(
    has_badge = if_else(badges != 0, "Paper has at least one badge", "Paper has no badge")) %>%
  mutate(
    has_badge = factor(has_badge, levels = c("Paper has no badge", "Paper has at least one badge"))
  )

total_papers <- df %>%
  pull(doi) %>%
  unique() %>%
  length()


plot <- df %>%
  select(how_shared, artefact_section, conference, has_badge) %>%
  mutate(how_shared = fct_infreq(how_shared)) %>%
  ggplot(aes(x = how_shared)) +
  geom_bar(aes(fill = conference)) +
  geom_text(data = . %>%
              group_by(how_shared) %>%
              summarize(
                n = n(),
                percentage = 100 * n() / total_papers
              ) %>% unique(),
            aes(y = n + 5, label = paste(round(percentage, 1), "%", sep="")),
            size = 3.5) +
  ylab("Number of papers") +
  xlab("") +
  ylim(0, 75) + # berk hard coded value so that the text is not cropped
  scale_fill_grey("2023 Conferences", start = 0.2, end = 0.8) +
  guides(fill = guide_legend(nrow = 2, byrow=TRUE)) +
  #ggtitle("How was the artifact shared?") +
  coord_flip()

ggsave(plot = plot, outfile, width=5, height=3.5)

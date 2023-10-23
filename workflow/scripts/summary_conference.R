library(tidyverse)

args = commandArgs(trailingOnly=TRUE)

csv_file = args[1]
out_file = args[2]

df <- read_csv(csv_file, col_names = T)

df


df %>%
    ggplot(aes(x = sw_env_method)) +
    geom_bar() +
    theme_bw() +
    theme(axis.text.x=element_text(angle=90, vjust=0.5))

df %>%
    group_by(doi) %>%
    summarize(badges = badges) %>%
    ggplot(aes(x = badges)) +
    geom_bar() +
    theme_bw()

df %>%
    select(doi, badge_avaible, badge_evaluated_functional, badge_reproduced) %>%
    group_by(doi) %>%
    summarize(
      badge_avaible = badge_avaible,
      badge_evaluated_functional = badge_evaluated_functional,
      badge_reproduced = badge_reproduced
    ) %>%
    pivot_longer(!c(doi), names_to="variable", values_to="value") %>%
    filter(value == TRUE) %>%
    ggplot(aes(x = variable)) +
    geom_bar() +
    theme_bw()

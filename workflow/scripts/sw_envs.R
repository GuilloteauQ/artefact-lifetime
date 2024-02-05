library(tidyverse)
theme_set(theme_bw() + theme(legend.position = "bottom"))


args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df <- read_csv(filename, col_names = T) %>%
  filter(repo_url) %>%
  filter(sw_env_method != "container" & sw_env_method != "vm") %>% # because it is actually taken care of in the "techno" column
  mutate(sw_env_method = if_else(sw_env_method == "modules", "module", sw_env_method)) %>% # because of a typo in the data....
  mutate(
    sw_env_method = fct_recode(sw_env_method,
      "Verified download" = "git_curl_commands_safest",
      "Nix" = "nix",
      "Vendoring" = "vendoring",
      "Spack" = "spack",
      "Loose image" = "untagged_or_short_life_base_image",
      "Module" = "module",
      "Conda" = "conda",
      "List" = "list",
      "List (>=)" = "list_loose_version",
      "Precise download" = "git_curl_commands_safe",
      "Nothing" = "none",
      "Unprecise download" = "git_curl_commands_unsafe",
      "pip" = "pip",
      "List (==)" = "list_strict_version",
      "apt commands" = "apt_commands"
    )
  )

total_papers <- df %>%
  pull(doi) %>%
  unique() %>%
  length()

plot <- df %>%
  mutate(sw_env_method = fct_infreq(sw_env_method)) %>%
  ggplot(aes(x = sw_env_method)) +
  geom_bar(aes(fill = conference)) +
  geom_text(data = . %>% group_by(sw_env_method) %>% summarize(n = n(), percentage = 100 * n() / total_papers),
            aes(y = n + 3, label = paste(round(percentage, 1), "%", sep="")),
            size = 4) +
  ylab("Number of papers") +
  xlab("") +
  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
  coord_flip()
  #theme(axis.text.x = element_text(angle = 45, hjust=1)) +

plot_per_badge <- df %>%
  select(
    sw_env_method, conference, badge_avaible, badge_evaluated_functional, badge_reproduced
  ) %>%
  rename(badge_available = badge_avaible) %>%
  pivot_longer(!c("sw_env_method", "conference"), names_to="badge", values_to="value") %>%
  mutate(sw_env_method = fct_infreq(sw_env_method)) %>%
  ggplot(aes(x = sw_env_method)) +
  geom_bar(data = . %>% filter(value), aes(fill = conference)) +
  ylab("Number of papers") +
  xlab("") +
  facet_wrap(~badge, ncol=3, scales = "free_x") +
  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
  coord_flip()

badges_labeller <- function(x) {
  paste("Number of badges: ", x, sep="")
}

plot_per_nb_badges <- df %>%
  select(
    sw_env_method, conference, badges
  ) %>%
  mutate(sw_env_method = fct_infreq(sw_env_method)) %>%
  ggplot(aes(x = sw_env_method)) +
  geom_bar(aes(fill = conference)) +
  ylab("Number of papers") +
  xlab("") +
  facet_wrap(~badges, ncol=2, scales = "free_x", labeller = labeller(badges = badges_labeller)) +
  scale_fill_grey("Conferences", start = 0.2, end = 0.8) +
  coord_flip()

ggsave(plot = plot, outfile, width=7, height=4)

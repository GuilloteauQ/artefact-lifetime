library(tidyverse)
# library(geomtextpath)
theme_set(theme_bw() + theme(legend.position = "bottom", strip.background = element_blank()))


args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df <- read_csv(filename, col_names = T) %>%
  filter(repo_url) %>%
  filter(sw_env_method != "container" & sw_env_method != "vm") %>% # because it is actually taken care of in the "techno" column
  mutate(sw_env_method = if_else(sw_env_method == "modules", "module", sw_env_method)) %>% # because of a typo in the data....
  mutate(how_shared = if_else(how_shared == "git" & pinned_version, "git+fixed", how_shared)) %>%
  mutate(sw_env_method = if_else((techno == "vm" | techno == "docker" | techno == "singularity") & bin_cache_long_term & recipe_in_repo, "docker_vm_recipe_long_term", sw_env_method)) %>%
  mutate(
    score_source_code = case_match(how_shared,
        c("zenodo", "git+fixed") ~ 1,
        "git+zenodo" ~ 3, # the collected data does not allow us to distinguish between a zenodo archive of a release or a dump of the git repo
        "swh" ~ 4,
        .default = 0
    ),
    score_experimental_setup = case_match(experimental_setup,
        "proprietary" ~ 1,
        "homemade" ~ 2,
        "supercomputer" ~ 3,
        c("simulation", "testbed") ~ 4,
        .default = 0
    ),
    score_software_env = case_match(sw_env_method,
        c("vendoring", "git_curl_commands_safe", "git_curl_commands_safest") ~ 1,
        "spack" ~ 2,
        "docker_vm_recipe_long_term" ~ 3,
        "nix" ~ 4,
        .default = 0
    )
  ) %>%
  group_by(doi, conference) %>%
  summarize(
    final_score_source_code = max(score_source_code),
    final_score_experimental_setup = max(score_experimental_setup),
    final_score_software_env = min(score_software_env), # `min` because there is one row per software methods, 
    final_score_global = (final_score_source_code + final_score_experimental_setup + final_score_software_env) / 3
  )

total_papers <- df %>%
  pull(doi) %>%
  unique() %>%
  length()

plot <- df %>%
  pivot_longer(!c("doi", "conference"), names_to = "scores", values_to = "value") %>%
  mutate(scores = fct_recode(scores,
     "1. Source code score" = "final_score_source_code",
     "2. Experimental platform score" = "final_score_experimental_setup",
     "3. Software environment score" = "final_score_software_env",
     "Overall Longevity score" = "final_score_global"
  )) %>%
  ggplot(aes(x = value)) +
  geom_ribbon(data = tibble(x = c(3, 4.3), y = c(total_papers + 15), scores = c("Overall Longevity score")), aes(x = x, ymin = 0, ymax = y), alpha = 0.2, fill = "green") +
  geom_ribbon(data = tibble(x = c(-.3, 3), y = c(total_papers + 15), scores = c("Overall Longevity score")), aes(x = x, ymin = 0, ymax = y), alpha = 0.2, fill = "red") +
  geom_bar() +
  # geom_textvline(data = . %>% filter(scores == "Global Longevity score"), aes(xintercept = 3), linetype = "dashed", label = "Threshold", hjust = 0.90) +
  geom_vline(data = . %>% filter(scores == "Overall Longevity score"), aes(xintercept = 3), linetype = "dashed") +
  geom_text(data = . %>% group_by(value, scores) %>% summarize(n = n(), percentage = 100 * n() / total_papers),
            aes(y = n + 15, label = paste(round(percentage, 1), "%", sep="")),
            size = 2.7) +
  geom_text(data = tibble(x = c((3 + (-0.3)) / 2, (4.3 + 3) / 2), y = total_papers - 12, label = c("No badge", "Badge"), scores = "Overall Longevity score"), aes(x = x, y = y, label = label)) +
  facet_wrap(~scores, ncol = 1) +
  xlab("Score") + ylab("Number of artifacts")
ggsave(plot=plot, outfile, width=5.5, height=4.5)

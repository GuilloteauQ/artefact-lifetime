library(tidyverse)
library(knitr)
library(kableExtra)

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df_unique <- read_csv(filename, col_names = T)

conf_core_rank <- tibble(
  conference = c("CCGRID", "EUROSYS", "OSDI", "PPOPP", "SC"),
  rank       = c("A", "A", "A*", "A", "A")
)

per_conf <- df_unique %>%
  left_join(conf_core_rank) %>%
  mutate(
    conference = paste(conference, " (", rank, ")", sep="")
  ) %>%
  select(-rank) %>%
  group_by(conference) %>%
  summarize(
    "Accepted" = n(),
    "Found PDF" = sum(pdf_available),
    "Artifact Section" = sum(artefact_section),

    "Specified" = sum(repo_url),
    "Dead" = sum(dead_url),

    "Available"  = sum(badge_avaible),
    "Functional" = sum(badge_evaluated_functional),
    "Reproduced" = sum(badge_reproduced)
  )

total_conf <- per_conf %>%
  pivot_longer(!c("conference")) %>%
  group_by(name) %>%
  mutate(Total = sum(value)) %>%
  select(-conference, -value) %>%
  pivot_longer(!c("name"), names_to = "conference", values_to = "value") %>%
  distinct(name, conference, value) %>%
  pivot_wider(id_cols=c("conference"), names_from = "name", values_from = "value")

linesep <- append(rep("", nrow(per_conf) - 1), "\\midrule")

per_conf %>%
  rbind(total_conf) %>%
  rename(Conference = conference) %>%
  knitr::kable(
      format="latex",
      align="lcccccccc",
      caption="Papers by considered conferences.",
      booktabs = TRUE,
      linesep = linesep,
      label="table:paper_confs",
      table.envir = "table*"
  ) %>%
  add_header_above(c(" " = 1, "Papers" = 3, "Artifact URL" = 2, "Badges" = 3))

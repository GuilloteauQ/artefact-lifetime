library(tidyverse)
library(knitr)

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

df_unique <- read_csv(filename, col_names = T)

per_conf <- df_unique %>%
  group_by(conference) %>%
  summarize(
    "Papers" = n(),
    "Found PDFs" = sum(pdf_available),
    "Repo URL" = sum(repo_url),
    "Dead URL" = sum(dead_url),
    "Artifact Section" = sum(artefact_section)
  )

total_conf <- per_conf %>%
  pivot_longer(!c("conference")) %>%
  group_by(name) %>%
  mutate(total = sum(value)) %>%
  select(-conference, -value) %>%
  pivot_longer(!c("name"), names_to = "conference", values_to = "value") %>%
  distinct(name, conference, value) %>%
  pivot_wider(id_cols=c("conference"), names_from = "name", values_from = "value")

linesep <- append(rep("", nrow(per_conf) - 1), "\\midrule")

per_conf %>%
  rbind(total_conf) %>%
  knitr::kable(format="latex", align="lccccc", caption="Papers considered by conferences.", booktabs = TRUE, linesep = linesep, label="table:paper_confs", table.envir = "table*")

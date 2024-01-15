library(tidyverse)

args = commandArgs(trailingOnly=TRUE)
filename = args[1]
outfile = args[2]

read_csv(filename, col_names = T) %>%
  group_by(doi) %>%
  top_n(1) %>%
  ungroup() %>%
  write_csv(outfile)

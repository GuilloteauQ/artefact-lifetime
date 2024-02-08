library(tidyverse)

args = commandArgs(trailingOnly=TRUE)
n = length(args)
files = args[1:(n-1)]
outfile = args[n]

get_df <- function(filename) {
    read_csv(filename, col_names = T)
}

files %>%
    map_df(get_df) %>%
    mutate(conference = str_to_upper(str_sub(conference, end=-3))) %>% # removing the 23 from the conference name, and capitalize
    write_csv(outfile)

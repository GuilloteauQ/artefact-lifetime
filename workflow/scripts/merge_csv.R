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
    write_csv(outfile)

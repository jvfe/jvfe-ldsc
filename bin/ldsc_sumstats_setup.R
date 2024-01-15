#!/usr/bin/env Rscript

library(dplyr)
library(readr)


args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
    stop("Usage: ldsc_sumstats_setup.r <sumstats> <variants> <output_name>", call. = FALSE)
}

sumstats_file <- args[1]

variants_file <- args[2]

output_name <- args[3]


# Read data from files
sumstats <- read_table(sumstats_file) %>%
  dplyr::select(variant, beta, se, pval, n_complete_samples)

ref <- read_table(variants_file)  %>%
  dplyr::select(variant, rsid, chr, ref, alt, info)

# Perform the join and selection
ldsc <- sumstats %>%
  inner_join(ref, by = "variant") %>%
  dplyr::select(SNP=rsid, CHR=chr, A1=ref, A2=alt, P=pval, BETA=beta, N=n_complete_samples, INFO=info)

write_tsv(ldsc, output_name)

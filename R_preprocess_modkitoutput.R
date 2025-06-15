#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 3) {
  stop("Usage: Rscript R_preprocess_modkitoutput.R <sampleID> <input_path> <output_path>")
}

sampleID    <- args[1]
input_path  <- args[2]
output_path <- args[3]

# Read input file
temp <- read.delim(input_path, header = FALSE)

# Normalize V11 to floats
temp$V11 <- temp$V11 / 100

# QC metrics
temp$TotalDepth <- rowSums(temp[, paste0("V", 12:18)])
temp$UsableFraction <- temp$V5 / temp$TotalDepth

temp_filtered <- temp[temp$UsableFraction > 0.5, ]
temp_filtered <- temp_filtered[temp_filtered$V5 > 8 & temp_filtered$V5 < 50, ]

# Create filtered output
output_filtered <- data.frame(IllmnID = temp_filtered$V19, Sample = temp_filtered$V11)
names(output_filtered)[names(output_filtered) == "Sample"] <- sampleID

write.table(
  output_filtered,
  output_path,
  quote = FALSE, sep = "\t", row.names = FALSE
)

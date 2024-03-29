# General setup ----------------------------------------------------------------
cat("\014")    # Clear console
rm(list=ls())  # Delete all variables
graphics.off() # Close all open plots

# Define variables
sample_size <- 1000000

# Define path and files
base_path <- "~/Documents/DataHack14/"
folder <- "Saturday_Data/"
file_name <- "Mobility_Signaling_Peering_Traffic"
suffix <- ".csv"
end_point_in <- paste(base_path, folder, file_name, suffix, sep="")
end_point_out <- paste(base_path, folder, file_name, "_subsample", suffix, sep="")
cat(file_name, "\n")
file_in <- file(end_point_in, "r")
file_out <- file(end_point_out, "w")

# Headers ------------------------------------------------------------------
headers <- readLines(file_in, n=1)
cat("Headers:", headers, "\n")
writeLines(headers, file_out) # copy headers

# Data ------------------------------------------------------------------
datasample <- readLines(file_in, n=sample_size)
writeLines(datasample, file_out) # Write only subsample data

# Wrap up ---------------------------------------------------------------------
close(file_in)
close(file_out)

cat('\nSubsample data written.')
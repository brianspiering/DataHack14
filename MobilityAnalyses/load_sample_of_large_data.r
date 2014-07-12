base_path <- "~/Documents/DataHack14/"
folder <- "Saturday_Data/" # "Tuesday_Data/" # 
#file_name <- "Mobility_Signaling_Operator_Traffic"
file_name <- "Mobility_Signaling_Peering_Traffic"
suffix <- ".csv"
end_point_in <- paste(base_path, folder, file_name, suffix, sep="")
end_point_out <- paste(base_path, folder, file_name, "_subsample", suffix, sep="")

cat(file_name, "\n")
file_in <- file(end_point_in,"r")
file_out <- file(end_point_out,"a")

# Headers ------------------------------------------------------------------
headers <- readLines(file_in, n=1)
cat(headers, "\n")
writeLines(headers, file_out) # copy headers

# Data ------------------------------------------------------------------
sample_size <- 100
datasample <- readLines(file_in, n=sample_size)
writeLines(datasample, file_out)

# Wrap up ---------------------------------------------------------------------
close(file_in)
close(file_out)
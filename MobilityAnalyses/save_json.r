# List of packages for session
.packages = c("rjson") 

# Install required CRAN packages (if not already installed)
.inst <- .packages %in% installed.packages()
if(length(.packages[!.inst]) > 0) install.packages(.packages[!.inst])

# Load packages into session 
lapply(.packages, require, character.only=TRUE)

# General setup ----------------------------------------------------------------
cat("\014")    # Clear console
rm(list=ls())  # Delete all variables
graphics.off() # Close all open plots

# Save table to json -----------------------------------------------------------
table_data <- table(round(runif(100, 1, 5))) # Mock data
sink("temp.json")
cat(toJSON(table_data))
sink()
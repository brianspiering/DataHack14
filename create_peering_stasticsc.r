#!/usr/bin/env Rscript

# File description -------------------------------------------------------------
# Create aggreatate statisics by country

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

# Load data -----------
cat('Loading data...\n')

if (version$os == "darwin10.8.0") {
  # Local - mac
  base_path <- "./"
  folder <- "data/"
  file_name <- "Mobility_Signaling_Peering_Traffic"
} else if (version$os == "linux-gnu"){
  # Remote - aws
  dir.create("output") # make output dir
  base_path <- ""
  folder <- ""
  file_name <- "Mobility_Signaling_Peering_Traffic"
}

suffix <- ".csv"
end_point_in <- paste(base_path, folder, file_name, suffix, sep="")
data_mobility_peering <- read.csv(end_point_in)

# str(Mobility_Signaling_Peering_Traffic) # Look at data
cat("Number of rows:", nrow(data_mobility_peering), "\n")
if (nrow(data_mobility_peering) < 10000) cat("WARNING: Running analysis on sample data. \n\n")

# Convert dataframe to numeric --------------------
data_mobility_peering$OUTBOUND_MESSAGES <- as.numeric(data_mobility_peering$OUTBOUND_MESSAGES)
data_mobility_peering$INBOUND_MESSAGES <- as.numeric(data_mobility_peering$INBOUND_MESSAGES)

# Define aggregate function-----------
outputAggs <- function(company, orig_country, dest_country, file_name) {
  # NOTE: Will throw error "no rows to aggregate" if not enough data
  cat("Calculating sums & counts (aka doin' data science): \n")
  both_country <- subset(data_mobility_peering, 
                         data_mobility_peering$DESTINATION_COUNTRY == dest_country 
                         & data_mobility_peering$ORIGINATION_COUNTRY == orig_country)
  
  agg_outbound <- aggregate(both_country$OUTBOUND_MESSAGES ~ both_country$PEERING_CUSTOMER_ID,
                            data = both_country,
                            FUN=sum)
  
  agg_inbound <- aggregate(both_country$INBOUND_MESSAGES ~ both_country$PEERING_CUSTOMER_ID,
                           data = both_country,
                           FUN=sum)
  
  agg_outbound <-  agg_outbound[order(agg_outbound[,2], decreasing=TRUE),]
  agg_inbound <- agg_inbound[order(agg_inbound[,2], decreasing=TRUE),]
  
  names(agg_outbound) <- c("customer_id", "outbound_messages")
  names(agg_inbound)<- c("customer_id", "inbound_messages")
  
  agg_both <- merge(agg_outbound, agg_inbound, by= "customer_id")
  agg_both$total_messages <- agg_both$inbound_messages + agg_both$outbound_messages
  total_data <- sum(agg_both$total_messages)
  
  
  # Define new variables
  data_json <- numeric()
  data_used <- numeric()
  
  # Write out data for each customer / company team member
  for(i in 1:nrow(agg_outbound)){    
    element <- list("cust_id" = as.numeric(agg_outbound[,1][i]), 
                    "data_used" = agg_outbound[,2][i])
    data_used <- append(data_used, list(element))  
  }
  
  # Create complete json object
  data_json <- list("event" = "World Cup", "company" = company,
                    "home_country" = orig_country,
                   "visiting_country" = dest_country,
                   "total_data" = total_data, "team_members"=data_used)  
  cat("Output:\n")
  print(data_json)

# Define output file path  
  path = "./output/"
  suffix = ".json"
  end_point_out <- paste(path, file_name, suffix, sep="")
  
  # Write file
  sink(end_point_out)
  cat(toJSON(data_json))
  sink()
  cat("JSON filed saved.") 
}

# Create json files ------------------------------------------------------------
# Sample json
company = "TATA"
orig_country <- "INDIA"
dest_country <- "ANTIGUA & BARB"
file_name <- "sample_output_001"
outputAggs(company, orig_country, dest_country, file_name)

# Paramters for full datasets
# # 1st json
# company = "WPP"
# orig_country <- "U. K."
# dest_country <- "BRAZIL"
# file_name <- "final_output_001"
# outputAggs(company, orig_country, dest_country, file_name)
# 
# # 2nd json
# company = "Facebook"
# orig_country<- "UNITED STATES"
# dest_country <- "BRAZIL"
# file_name <- "final_output_002"
# outputAggs(company, orig_country, dest_country, file_name)

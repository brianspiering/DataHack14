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

# Local box vs AWS
if (version$os =="darwin10.8.0") {
  # Local
  base_path <- "~/Documents/DataHack14/"
  folder <- "Saturday_Data/"
  file_name <- "Mobility_Signaling_Peering_Traffic_subsample"
} else if ("linux-gnu"){
  # Remote 
  dir.create("data") # make output dir
  base_path <- ""
  folder <- ""
  file_name <- "Mobility_Signaling_Peering_Traffic_subsample"
  cat("TODO: Complete dataset")

}

suffix <- ".csv"
end_point_in <- paste(base_path, folder, file_name, suffix, sep="")
Mobility_Signaling_Peering_Traffic <- read.csv(end_point_in)

# str(Mobility_Signaling_Peering_Traffic) # Look at data
cat("Number of rows:", nrow(Mobility_Signaling_Peering_Traffic), "\n")

# Convert dataframe numeric --------------------
Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES <- as.numeric(Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES)
Mobility_Signaling_Peering_Traffic$INBOUND_MESSAGES <- as.numeric(Mobility_Signaling_Peering_Traffic$INBOUND_MESSAGES)

# Define aggregate function-----------
outputAggs <- function(company, orig_country, dest_country, file_name) {
  cat("Calculating sums & counts (aka doin' data science) \n")
  both_country <- subset(Mobility_Signaling_Peering_Traffic, 
                         Mobility_Signaling_Peering_Traffic$DESTINATION_COUNTRY == dest_country 
                         & Mobility_Signaling_Peering_Traffic$ORIGINATION_COUNTRY == orig_country)
  
  agg_outbound <- aggregate(both_country$OUTBOUND_MESSAGES ~ both_country$PEERING_CUSTOMER_ID,
                            data = both_country,
                            FUN=sum)
  
  agg_inbound <- aggregate(both_country$INBOUND_MESSAGES ~ both_country$PEERING_CUSTOMER_ID,
                           data = both_country,
                           FUN=sum)
  
  agg_outbound <-  agg_outbound[order(agg_outbound[,2], decreasing=TRUE),]
  #agg_outbound[1:10,]
  
  agg_inbound <- agg_inbound[order(agg_inbound[,2], decreasing=TRUE),]
  print(agg_inbound)
  #agg_inbound[1:10,]

  names(agg_outbound) <- c("customer_id", "outbound_messages")
  names(agg_inbound)<- c("customer_id", "inbound_messages")
  
  agg_both <-merge(agg_outbound, agg_inbound, by= "customer_id")
  # Save data to json -----------------------------------------------------------
  
  agg_both$total_messages <- agg_both$inbound_messages + agg_both$outbound_messages
  total_data <- sum(agg_both$total_messages)

  # Define new variables
  json <- numeric()
  data_used <- numeric()

  # Write out data for each customer / company team member
  for(i in 1:nrow(agg_outbound)){    
    element <- list("cust_id" = as.numeric(agg_outbound[,1][i]), "data_used" = agg_outbound[,2][i])
    data_used <- append(data_used, list(element))  
  }
  
  # Create complete json object
  json <- list("event" = "World Cup", "company" = company,
               "home_country" = orig_country,
               "visiting_country" = dest_country,
               "total_data" = total_data, "team_members"=data_used)  
  
  # Define output file path  
  path = "./data/"
  suffix = ".json"
  end_point_out <- paste(path, file_name, suffix, sep="")
  
  # Write file
  sink(end_point_out)
  cat(toJSON(json))
  sink()
  cat("JSON filed saved.") 
}

# 1st json ------------------
company = "WPP"
orig_country <- "U. K."
dest_country <- "BRAZIL"
file_name <- "sample_data_001"
outputAggs(company, orig_country, dest_country, file_name)

# 2nd json ------------------
company = "Facebook"
orig_country<- "UNITED STATES"
dest_country <- "BRAZIL"
file_name <- "sample_data_002"
outputAggs(company, orig_country, dest_country, file_name)

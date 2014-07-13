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

# Define variables ---------------------
orig_country <- "U. K."
dest_country <- "BRAZIL"

#orig_country<- "UNITED STATES"
#dest_country <- "BRAZIL"

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
  base_path <- ""
  folder <- "data/"
  file_name <- "Mobility_Signaling_Peering_Traffic_subsample"
}


suffix <- ".csv"
end_point_in <- paste(base_path, folder, file_name, suffix, sep="")
Mobility_Signaling_Peering_Traffic <- read.csv(end_point_in)

# str(Mobility_Signaling_Peering_Traffic) # Look at data
cat("Number of rows:", nrow(Mobility_Signaling_Peering_Traffic))

# Convert dataframe numeric --------------------
Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES <- as.numeric(Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES)
Mobility_Signaling_Peering_Traffic$INBOUND_MESSAGES <- as.numeric(Mobility_Signaling_Peering_Traffic$INBOUND_MESSAGES)

# Define aggregate function-----------
outputAggs <- function(orig_country, dest_country) {
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
  #agg_inbound[1:10,]
  
  # Save data to json -----------------------------------------------------------
  #table_data <- table(round(runif(100, 1, 5))) # Mock data
  table_data <- table("event", "World Cup")
  table_data <- table(agg_inbound)
    
  total_data<- sum(both_country$OUTBOUND_MESSAGES)
  json <- numeric()

  data_used <- numeric()
  
  k<- nrow(agg_outbound)
  
  for(i in 1:k){    
    element<- list("cust_id" = as.numeric(agg_outbound[,1][i]), "data_used" = agg_outbound[,2][i])
    data_used <- append(data_used, list(element))  
  }
  
  
  json <- list("event" = "World Cup", "company" = "Facebook",
               "home_country" = orig_country,
               "visiting_country" = dest_country,
               "total_data" = total_data, "team_members"=list(data_used))   

  #json <- append(json, list(data_used))
  
  
  
  #end_point_in <- paste(path, "in",name, type, sep="")
  
  base_path <- "~/Documents/DataHack14/"
  folder <- "Saturday_Data/" # "Tuesday_Data/" # 
  file_name <- "Mobility_Signaling_Peering_Traffic_subsample"
  suffix <- ".csv"
  end_point_in <- paste(base_path, folder, file_name, suffix, sep="")
  
  
  path = ""
  type = ".json"
  end_point_out <- paste(path, "out",orig_country,dest_country,type, sep="")

  
  sink(end_point_out)
  cat(toJSON(json))
  sink()
  
  
}

outputAggs(orig_country, dest_country)

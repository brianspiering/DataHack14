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
cat('Loading data ...' \n)
base_path <- "~/Documents/DataHack14/"
folder <- "Saturday_Data/" # "Tuesday_Data/" # 
file_name <- "Mobility_Signaling_Peering_Traffic_subsample"
suffix <- ".csv"
end_point_in <- paste(base_path, folder, file_name, suffix, sep="")
Mobility_Signaling_Peering_Traffic <- read.csv(end_point_in)

# str(Mobility_Signaling_Peering_Traffic) # Look at data

# Make data frame numeric --------------------
Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES <- as.numeric(Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES)
Mobility_Signaling_Peering_Traffic$INBOUND_MESSAGES <- as.numeric(Mobility_Signaling_Peering_Traffic$INBOUND_MESSAGES)


# Primary Function-----------
outputAggs <- function(orig_country, dest_country) {
  both_country <- subset(Mobility_Signaling_Peering_Traffic, 
                         Mobility_Signaling_Peering_Traffic$DESTINATION_COUNTRY == dest_country 
                         & Mobility_Signaling_Peering_Traffic$ORIGINATION_COUNTRY == orig_country)
  
  #str(both_country)
  #length(unique(both_country$PEERING_CUSTOMER_ID))
  
  
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
  
  # Load R object ----------------------------------------------------------------
  path <- "./data/"
  name <- paste(orig_country, dest_country)  
  type <- ".rdata"
  
  end_point_in <- paste(path, "in",name, type, sep="")
  end_point_out <- paste(path, "out",name, type, sep="")
  
  saveRDS(agg_inbound, end_point_in)
  saveRDS(agg_outbound, end_point_out)
  
}



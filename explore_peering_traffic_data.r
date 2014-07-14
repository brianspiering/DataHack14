# General setup ----------------------------------------------------------------
cat("\014")    # Clear console
rm(list=ls())  # Delete all variables
graphics.off() # Close all open plots

# Load data -----------
base_path <- "./"
folder <- "data/"
file_name <- "Mobility_Signaling_Peering_Traffic"
suffix <- ".csv"
end_point_in <- paste(base_path, folder, file_name, suffix, sep="")
Mobility_Signaling_Peering_Traffic <- read.csv(end_point_in)

Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES <- as.numeric(Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES)
Mobility_Signaling_Peering_Traffic$INBOUND_MESSAGES <- as.numeric(Mobility_Signaling_Peering_Traffic$INBOUND_MESSAGES)

# Explore data -----
# View(Mobility_Signaling_Peering_Traffic)
head(Mobility_Signaling_Peering_Traffic)
str(Mobility_Signaling_Peering_Traffic)

# Analyze customers -----------
#41 different peering customers.
table(Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES)
hist(Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES)
head(Mobility_Signaling_Peering_Traffic)
table(Mobility_Signaling_Peering_Traffic$PEERING_CUSTOMER_ID)
str(Mobility_Signaling_Peering_Traffic)

# Analyze single customer -------------
subset(Mobility_Signaling_Peering_Traffic, Mobility_Signaling_Peering_Traffic$PEERING_CUSTOMER_ID == "iBN0")

sum(Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES)
sum(Mobility_Signaling_Peering_Traffic$INBOUND_MESSAGES)

str(Mobility_Signaling_Peering_Traffic)
aggregate(Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES ~ Mobility_Signaling_Peering_Traffic$PEERING_CUSTOMER_ID,
         data = Mobility_Signaling_Peering_Traffic,
         FUN=sum)

OUTBOUND <- aggregate(Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES ~ Mobility_Signaling_Peering_Traffic$PEERING_CUSTOMER_ID,
                      data = Mobility_Signaling_Peering_Traffic,
                      FUN=sum)
INBOUND <- aggregate(Mobility_Signaling_Peering_Traffic$INBOUND_MESSAGES ~ Mobility_Signaling_Peering_Traffic$PEERING_CUSTOMER_ID,
                     data = Mobility_Signaling_Peering_Traffic,
                     FUN=sum)

OUTBOUND <-  OUTBOUND[order(OUTBOUND[,2], decreasing=TRUE),]
OUTBOUND[1:10,]
topCustomersOut <- OUTBOUND[1:10,][1]

INBOUND <- INBOUND[order(INBOUND[,2], decreasing=TRUE),]
INBOUND[1:10,]
topCustomersIn <- INBOUND[1:10,][1]


table(Mobility_Signaling_Peering_Traffic$ORIGINATION_COUNTRY)

UK_inbound <- subset(Mobility_Signaling_Peering_Traffic, Mobility_Signaling_Peering_Traffic$ORIGINATION_COUNTRY == "UNITED STATES")
str(Mobility_Signaling_Peering_Traffic)




#inbound_country <- subset(Mobility_Signaling_Peering_Traffic, Mobility_Signaling_Peering_Traffic$ORIGINATION_COUNTRY == orig_country)
#outbound_country <- subset(Mobility_Signaling_Peering_Traffic, Mobility_Signaling_Peering_Traffic$DESTINATION_COUNTRY == dest_country)

orig_country<- "U. K."
dest_country <- "BRAZIL"

orig_country<- "UNITED STATES"
dest_country <- "BRAZIL"


both_country <- subset(Mobility_Signaling_Peering_Traffic, 
                       Mobility_Signaling_Peering_Traffic$DESTINATION_COUNTRY == dest_country & 
                         Mobility_Signaling_Peering_Traffic$ORIGINATION_COUNTRY == orig_country)

#str(both_country)
#length(unique(both_country$PEERING_CUSTOMER_ID))


agg_outbound <- aggregate(both_country$OUTBOUND_MESSAGES ~ both_country$PEERING_CUSTOMER_ID,
          data = both_country,
          FUN=sum)

agg_inbound <- aggregate(both_country$INBOUND_MESSAGES ~ both_country$PEERING_CUSTOMER_ID,
                          data = both_country,
                          FUN=sum)


agg_outbound <-  agg_outbound[order(agg_outbound[,2], decreasing=TRUE),]
agg_outbound[1:10,]

agg_inbound <-  agg_inbound[order(agg_inbound[,2], decreasing=TRUE),]
agg_inbound[1:10,]


name <- paste(orig_country, dest_country)

filename_out <- paste(name, "outbound.csv")
filename_in <- paste(name, "inbound.csv")

write.table(agg_outbound, file= filename_out)


# Save summary data ---
end_point_out <- paste(base_path, folder, file_name, "_summary", suffix, sep="")

subset(Mobility_Signaling_Peering_Traffic, Mobility_Signaling_Peering_Traffic$PEERING_CUSTOMER_ID == "i5BE")
str(Mobility_Signaling_Peering_Traffic)
Mobility_Signaling_Operator_Traffic <- read.csv("/Volumes/Windows/DataHack14/VivekAnalyses/Data Samples/Mobility_Signaling_Operator_Traffic.csv")
str(Mobility_Signaling_Operator_Traffic)

#200 obs, 9 vars
head(Mobility_Signaling_Operator_Traffic)
str(Mobility_Signaling_Operator_Traffic$ORIGINATION_NETWORK_ID)
#136 origin points.
str(Mobility_Signaling_Operator_Traffic$DESTINATION_NETWORK_ID)
#151 destination points

str(Mobility_Signaling_Operator_Traffic$ORIGINATION_COUNTRY)
#45 counrtries
sum(Mobility_Signaling_Operator_Traffic$OUTBOUND_MESSAGES)

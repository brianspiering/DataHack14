
path <- "/Volumes/Windows/DataHack14/VivekAnalyses/Data Samples/"
filename <- "Mobility_Signaling_Operator_Traffic.csv"
end_point <- paste(path, filename, sep="")

Mobility_Signaling_Operator_Traffic <- read.csv(end_point)
str(Mobility_Signaling_Operator_Traffic)
View(Mobility_Signaling_Operator_Traffic)
#200 obs, 9 vars
head(Mobility_Signaling_Operator_Traffic)
str(Mobility_Signaling_Operator_Traffic$ORIGINATION_NETWORK_ID)
#136 origin points.
str(Mobility_Signaling_Operator_Traffic$DESTINATION_NETWORK_ID)
#151 destination points

str(Mobility_Signaling_Operator_Traffic$ORIGINATION_COUNTRY)
#45 counrtries
sum(Mobility_Signaling_Operator_Traffic$OUTBOUND_MESSAGES)

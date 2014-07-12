Mobility_Signaling_Peering_Traffic <- read.csv("~/Dropbox/data hack/Data Samples/Mobility_Signaling_Peering_Traffic.csv")

View(Mobility_Signaling_Peering_Traffic)

Mobility_Signaling_Peering_Traffic

head(Mobility_Signaling_Peering_Traffic)
str(Mobility_Signaling_Peering_Traffic)

#41 different peering customers.
table(Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES)
hist(Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES)
head(Mobility_Signaling_Peering_Traffic)

table(Mobility_Signaling_Peering_Traffic$PEERING_CUSTOMER_ID)
str(Mobility_Signaling_Peering_Traffic)
#100 obs
#41 diff customers

subset(Mobility_Signaling_Peering_Traffic, Mobility_Signaling_Peering_Traffic$PEERING_CUSTOMER_ID == "iBN0")

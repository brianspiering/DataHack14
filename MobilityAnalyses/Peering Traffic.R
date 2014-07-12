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

Mobility_Signaling_Peering_Traffic
sum(Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES)
sum(Mobility_Signaling_Peering_Traffic$INBOUND_MESSAGES)
aggregate(Mobility_Signaling_Peering_Traffic$PEERING_CUSTOMER_ID)

str(Mobility_Signaling_Peering_Traffic)
aggregate(Mobility_Signaling_Peering_Traffic$OUTBOUND_MESSAGES ~ Mobility_Signaling_Peering_Traffic$PEERING_CUSTOMER_ID, data = Mobility_Signaling_Peering_Traffic, FUN=sum)

OUTBOUND<-aggregate(Mobility_Signaling_Peering_Traffic$INBOUND_MESSAGES ~ Mobility_Signaling_Peering_Traffic$PEERING_CUSTOMER_ID, data = Mobility_Signaling_Peering_Traffic, FUN=sum)


INBOUND<-aggregate(Mobility_Signaling_Peering_Traffic$INBOUND_MESSAGES ~ Mobility_Signaling_Peering_Traffic$PEERING_CUSTOMER_ID, data = Mobility_Signaling_Peering_Traffic, FUN=sum)

OUTBOUND
str(OUTBOUND)


attach(OUTBOUND)
detach(OUTBOUND)


OUTBOUND[,order(OUTBOUND$Mobility_Signaling_Peering_Traffic$INBOUND_MESSAGES)]


INBOUND

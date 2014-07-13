IPT_Qos_Performance <- read.csv("~/Dropbox/data hack/Data Samples/IPT_Qos_Performance.csv")
View(IPT_Qos_Performance)
rm(IPT_Traffic)
str(IPT_Qos_Performance)
#Is there an association between A Sites designation and it's actual location int he world?

summary(IPT_Qos_Performance$AVG_LATENCY.ms.)
hist(IPT_Qos_Performance$AVG_LATENCY.ms.)
cor(IPT_Qos_Performance$AVG_LATENCY.ms., IPT_Qos_Performance$AVG_PACKET_LOSS....)
#A very small relationship, negative .0287, that says with increases in latency there
#Are decreases in average packet loss.
hist(IPT_Qos_Performance$AVG_PACKET_LOSS....)
table(IPT_Qos_Performance$AVG_PACKET_LOSS....)

IPT_Qos_Performance$connection <- paste(IPT_Qos_Performance$SITE_A, IPT_Qos_Performance$SITE_B)
  as.character(IPT_Qos_Performance$SITE_A[2]) + as.character(IPT_Qos_Performance$SITE_B[1])
paste(IPT_Qos_Performance$SITE_A[2], IPT_Qos_Performance$SITE_B[3])
IPT_Qos_Performance$connection
table(IPT_Qos_Performance$connection)

summary(IPT_Qos_Performance)
cor(IPT_Qos_Performance$AVG_PACKET_LOSS...., IPT_Qos_Performance$AVG_LATENCY.ms.)
cor(IPT_Qos_Performance$AVG_JITTER.ms., IPT_Qos_Performance$AVG_LATENCY.ms.)
#.24 relation between jitter and latency!
cor(IPT_Qos_Performance$AVG_JITTER.ms., IPT_Qos_Performance$AVG_PACKET_LOSS....)
#.10 relation between jiter and packet loss.
#IP Transit is about 

IPT_Traffic <- read.csv("~/Dropbox/data hack/Data Samples/IPT_Traffic.csv")
IPT_Traffic$CUSTOMER_ID <- as.factor(IPT_Traffic$CUSTOMER_ID)
IPT_Traffic
View(IPT_Traffic)

IPT_Traffic
summary(IPT_Traffic)

head(IPT_Traffic)
summary(IPT_Traffic$CUSTOMER_ID)
str(IPT_Traffic)

summary(IPT_Traffic$CUSTOMER_ID)
IPT_Traffic$CUSTOMER_ID

summary(IPT_Traffic$SPEED.Mpbs.)
hist(IPT_Traffic$SPEED.Mpbs.)
table(IPT_Traffic$SPEED.Mpbs.)
cor(IPT_Traffic$SPEED.Mpbs., IPT_Traffic$MINIMUM_COMMITMENT.Mbps.)
IPT_Traffic$Extra <- IPT_Traffic$SPEED.Mpbs. - IPT_Traffic$MINIMUM_COMMITMENT.Mbps.
summary(IPT_Traffic$Extra)
IPT_Traffic$Extra
sum(IPT_Traffic$Extra)
sum(IPT_Traffic$SPEED.Mpbs.)
sum(IPT_Traffic$MINIMUM_COMMITMENT.Mbps.)

http://www.forbes.com/forbes/1999/0419/6308242a.html
The critical moment came in October 1997 when Winnick gathered industry 
executives at a Marriott on New Yorks East Side to announce prices. 
The going rate was $20 million a circuit, a circuit being enough bandwidth on a 
fiber to handle 155 megabits per second. Winnick said he would charge $8 million.
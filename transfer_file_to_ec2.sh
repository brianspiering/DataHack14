#!/usr/bin/env bash
scp -i ~/.ssh/datahack14.pem ~/Documents/DataHack14/Saturday_Data/Mobility_Signaling_Peering_Traffic ubuntu@ec2-54-201-161-124.us-west-2.compute.amazonaws.com:~/.
scp -i ~/.ssh/datahack14.pem temp.txt ubuntu@ec2-54-201-161-124.us-west-2.compute.amazonaws.com:

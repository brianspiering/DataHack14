# Move data from local to remote
scp -i ~/.ssh/datahack14_oregon.pem ~/Documents/DataHack14/Saturday_Data/Mobility_Signaling_Peering_Traffic_subsample.csv ubuntu@ec2-54-186-213-176.us-west-2.compute.amazonaws.com:

<<<<<<< HEAD
# Move data from s3 to remote
wget https://s3-us-west-2.amazonaws.com/sparklydata/Mobility_Signaling_Peering_Traffic_subsample.csv
=======
ssh -i ~/.ssh/datahack14_oregon.pem ubuntu@ec2-54-187-200-110.us-west-2.compute.amazonaws.com
>>>>>>> FETCH_HEAD

# Move data to rstudio dir on remote
sudo mv Mobility_Signaling_Peering_Traffic.tar /home/rstudio

# untar


##
~/Documents/DataHack14/Saturday_Data/Mobility_Signaling_Peering_Traffic.tar
~/Documents/DataHack14/Saturday_Data/Mobility_Signaling_Peering_Traffic_subsample.csv

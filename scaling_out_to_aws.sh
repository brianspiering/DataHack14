# Create ec2 instance with RStudio - http://www.louisaslett.com/RStudio_AMI/

# Move data from local to remote
scp -i ~/.ssh/datahack14_oregon.pem ~/Documents/DataHack14/Saturday_Data/Mobility_Signaling_Peering_Traffic.tar ubuntu@ec2-54-186-213-176.us-west-2.compute.amazonaws.com:

# Move data from s3 to remote
wget https://s3-us-west-2.amazonaws.com/sparklydata/Mobility_Signaling_Peering_Traffic_subsample.csv

# Move data to rstudio dir on remote
sudo mv Mobility_Signaling_Peering_Traffic_subsample.csv /home/rstudio

# untar

#!/bin/bash
#################################
#Author: Praveen
#Date:10-02-2024
#
#Version:v1.0
#
#This Script will get the AWS resource details
#`aws configure` should be done before execution
##################################
#get a current date with hour and min
CURRENTDATE=`date +"%Y-%m-%d_%H-%M"`

set -x
echo $CURRENTDATE


#Get EC2 Instance
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'> /home/ec2-user/ResourceData_$CURRENTDATE.txt

#Get S3 buckets
aws s3 ls| awk -F " " '{print $3}' >> /home/ec2-user/ResourceData_$CURRENTDATE.txt

#Get IAM Users
aws iam list-users | jq '.Users[].UserName' >> /home/ec2-user/ResourceData_$CURRENTDATE.txt

#Get list of lambda functions
aws lambda list-functions >> /home/ec2-user/ResourceData_$CURRENTDATE.txt


#PATH=/usr/bin:/usr/local/bin
#* * * * * sh /home/ec2-user/getAWSResourceDetails.sh >> /home/ec2-user/getAWSResourceDetails.log 2>&1

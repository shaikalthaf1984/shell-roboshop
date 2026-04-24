#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-0c07985272092a461"

for instance in $@
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-0220d79f3f480ecf5 --instance-type t3.micro --security-group-ids sg-0c07985272092a461 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' --output text)

    #to get private ip address
    if [ $instance != "frontend"]; then
        IP=$(aws ec2 describe-instances --instance-ids i-0863b9cd92831b9e5 --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids i-0863b9cd92831b9e5 --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)

    fi
        echo "$instance: $"
done

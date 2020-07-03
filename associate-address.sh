#!/bin/bash

# Associates an Elastic IP with the given Name: tag to the current instance.
# Requires the instance have an IAM role with ec2:DescribeAddresses and ec2:AssociateAddress

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
AWS_REGION=$(curl -s 169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//')

ALLOCATION_ID=$(aws ec2 describe-addresses --region=$AWS_REGION --filters "Name=tag:Name,Values=$1" --query 'Addresses[0].AllocationId' | tr -d '"')

aws ec2 associate-address --region $AWS_REGION --allocation-id $ALLOCATION_ID --instance-id $INSTANCE_ID

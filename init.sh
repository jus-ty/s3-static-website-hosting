#!/bin/bash

# NOTE: This script will prompt for region selection and create your terraform state bucket,
# you must have the AWS CLI installed AND run this script from an IAM User/Role that allows the S3:CreateBucket action.

rm -f conf.config




# Region Selection

echo 'Please select a number from the AWS region list:'
sleep 2
nl region.list
count="$(wc -l region.list | cut -f 1 -d' ')"
n=""
while true; do
    read -p 'Enter number (e.g 3 for us-west-1): ' n
    # If $n is an integer between one and $count...
    if [ "$n" -eq "$n" ] && [ "$n" -gt 0 ] && [ "$n" -le "$count" ]; then
        break
    fi
done
aws_region="$(sed -n "${n}p" region.list)"
echo "The user selected option number $n: '$aws_region'"

echo "aws_region=${aws_region}" >> conf.config





# Terraform state bucket creation
byo_state_bucket=${1,,}

if [ -z "$byo_state_bucket" ]; then
    account_number=$(aws sts get-caller-identity --query Account --output text)
    state_bucket_name="terraform-state-${account_number}"
    aws s3 mb "s3://${state_bucket_name}" --region "${aws_region}"
else
    state_bucket_name="${byo_state_bucket}"
fi

echo "state_bucket_name=${state_bucket_name}" >> conf.config

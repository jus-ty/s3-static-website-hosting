#!/usr/bin/env bash

# NOTE: This script will prompt for region selection and create your terraform state bucket,
# you must have the AWS CLI installed AND run this script from an IAM User/Role that allows the S3:CreateBucket action.

rm -f conf.config

# Hosting Bucket name

website_bucket_name=""
read -p 'Enter the domain name of your website (without protocol or top level domain): ' website_bucket_name


# Top Level Domain Selection

echo 'Please select a Top Level Domain (TLD) from the following list:'
sleep 2
nl tld.list
count="$(wc -l tld.list | cut -f 1 -d' ')"
n_tld=""
while true; do
    read -p 'Enter number (e.g 2 for .net): ' n_tld
    # If $n_tld is an integer between one and $count...
    if [ "$n_tld" -eq "$n_tld" ] && [ "$n_tld" -gt 0 ] && [ "$n_tld" -le "$count" ]; then
        break
    fi
done

tld="$(sed -n "${n_tld}p" tld.list)"
echo "The user selected option number $n_tld: '$tld'"

if [ "$tld" == "OTHER (Not listed above)" ]; then
    tld=""
    read -p 'Enter the Top Level Domain (TLD) (e.g .xyz): ' tld
fi

echo "website_bucket_name=${website_bucket_name}${tld}" >> conf.config

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

account_number=$(aws sts get-caller-identity --query Account --output text)
echo "account_number=${account_number}" >> conf.config

if [ -z "$byo_state_bucket" ]; then
    state_bucket_name="terraform-state-${account_number}"
    aws s3 mb "s3://${state_bucket_name}" --region "${aws_region}"
else
    state_bucket_name="${byo_state_bucket}"
fi

echo "state_bucket_name=${state_bucket_name}" >> conf.config

#!/usr/bin/env bash
action=${1,,}

source ./conf.config


# Parameter validation: action
if [ "$action" == "plan" ]; then
    echo "Plan action selected!"
elif [ "$action" == "apply" ]; then
    echo "Apply action selected!"
elif [ "$action" == "destroy" ]; then
    echo "Destroy action selected!"
else
    echo "Invalid action selected. Must be one of: 'plan', 'apply' or 'destroy'"
    exit
fi

# Get branch name
branch_name=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
workspace_name="s3-static-website-hosting-$account_number"

cd infra

terraform init -reconfigure \
-backend-config="bucket=$state_bucket_name" \
-backend-config="key=$workspace_name" \
-backend-config="region=$aws_region"

terraform workspace select $workspace_name || terraform workspace new $workspace_name

terraform $action -var-file="environment/terraform.tfvars" -var "aws_region=$aws_region" -var "git_branch=$branch_name" -var "bucket_name=$website_bucket_name"

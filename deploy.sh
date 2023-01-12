#!/bin/bash
action=${1,,}

source ./conf.config

echo "$aws_region"
echo "$state_bucket_name"


# Parameter validation: action
# if [ "$action" == "plan" ]; then
#     echo "Plan action selected!"
# elif [ "$action" == "apply" ]; then
#     echo "Apply action selected!"
# elif [ "$action" == "destroy" ]; then
#     echo "Destroy action selected!"
# else
#     echo "Invalid action selected. Must be one of 'plan', 'apply' or 'destroy'"
#     exit
# fi

# # Get branch name
# branch_name=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
# name="s3_static_website_hosting_terraform_state"

# cd terraform

# terraform init -reconfigure \
# -backend-config="bucket=${state_bucket}" \
# -backend-config="key=$name" \
# -backend-config="region=${region}"

# terraform workspace select $name || terraform workspace new $name

# terraform $action -var-file="environment/terraform.tfvars" -var "git_branch=$branch_name"
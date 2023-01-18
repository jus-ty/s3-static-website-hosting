# General
variable "aws_region" {
    description = "The AWS region to create the resource"
    type        = string
}

variable "git_branch" {
    description = "Name of the branch being used for deployment"
    type        = string
}

variable "generic_tags" {
    description = "Generic tags for all resources"
    type        = map(string)
}

variable "bucket_name" {
    description = "Name of the S3 bucket that will host the website"
    type        = string
}

variable "website_hosting_bucket_name" {
    description = "Name of the S3 bucket that will host the website"
    type        = string
}

variable "website_hosting_bucket_tags" {
    description = "Tags for the S3 bucket that will host the website"
    type        = map(string)
}
# s3-static-website-hosting
Project to setup S3 Static Website hosting on AWS

#### Requirements
- Terraform
- AWS CLI configured with a role that can provision AWS Resources

#### Setup

1. Complete region selection and terraform state bucket creation by running ./init.sh
    - If you already have a terraform state bucket in your account and wish to use that one:
        - Run ./init.sh <<STATE_BUCKET_NAME>> ... and enter the region of that bucket when prompted

- Terraform to setup:
    - S3 bucket (w/ public access) + tags + Static hosting setup + Bucket policy
    - R53???

- Script to upload the html files into your S3 bucket?

Notes:

Resume webpage (S3 Static Site + R53?, https://justinlewiswalton.com/)

https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html

https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteEndpoints.html

.. with BLOG POSTS!




BUCKET POLICY:

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::<<Bucket-Name>>/*"
            ]
        }
    ]
}
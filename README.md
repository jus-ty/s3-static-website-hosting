# s3-static-website-hosting
Project to setup S3 Static Website hosting on AWS

#### Requirements
- Terraform
- AWS CLI configured with a role that can provision AWS Resources

#### Setup

1. Edit the html files under src to your requirements/desire!

2. Complete region selection and terraform state bucket creation by running ./init.sh
    - If you already have a terraform state bucket in your account and wish to use that one:
        - Run ./init.sh <<STATE_BUCKET_NAME>>

3. Run ./deploy.sh <<ACTION>>
- First action should be plan, then after verifying the plan, run again with apply

4. Your S3 Static website should now be running! You can access it with the S3 endpoint in your bucket under Properties > Static website hosting > Bucket website endpoint

5. (OPTIONAL) You may also decide to have a Route53/BYO Domain linking to your static website, you can follow this guide:
https://youtu.be/fm6FPQMZ_WI?t=319

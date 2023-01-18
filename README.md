# s3-static-website-hosting
Project to setup S3 Static Website hosting on AWS

#### Requirements
- Terraform
- AWS CLI configured with a role used for provisioning resources

#### Setup

1. Edit the html files under src to your requirements/desire!

2. Complete region selection and terraform state bucket creation by running ./init.sh
    - If you already have a terraform state bucket in your account and wish to use that one:
        - Run ./init.sh <<STATE_BUCKET_NAME>>

3. Run ./deploy.sh <<TF_ACTION>>
- First action should be plan, then after verifying the plan, run again with apply

4. Your S3 Static website should now be running! You can access it with the S3 endpoint in your bucket under Properties > Static website hosting > Bucket website endpoint

5. (OPTIONAL) You may also decide to have a Route53/BYO Domain linking to your static website.

- If you have a domain that you own, outside of AWS Route53, you can follow this guide:
https://youtu.be/fm6FPQMZ_WI?t=319

- If you have a domain registered in Route53:

(1) Navigate to Route53 > Hosted Zones. AWS would've already created a public hosted zone for you once your domain was successfully registered.

(2) Click on the hosted zone with your desired domain name and click on 'Create Record'

(3) Create the record with the following setup (root domain):
- Record name: <<Leave it blank>>
- Record type: A record (Routes to an IPv4 address and some AWS resources
- Alias: True
- Route traffic to: Alias to S3 website endpoint > Select your region > Select your S3 endpoint (If none appears, type: s3-website-<<REGION_NAME>>.amazonaws.com)
- Routing policy: Whatever you desire (If you don't know which one to pick, select 'Simple routing')
- Evaluate target health: No

(4) Create the record with the following setup (sub domain):
- Record name: www
- Record type: A record (Routes to an IPv4 address and some AWS resources
- Alias: True
- Route traffic to: Alias to S3 website endpoint > Select your region > Select your S3 endpoint (If none appears, type: s3-website-<<REGION_NAME>>.amazonaws.com)
- Routing policy: Whatever you desire (If you don't know which one to pick, select 'Simple routing')
- Evaluate target health: No

(5) Your R53 domain should now evaluate to your static website!




References:
- https://docs.aws.amazon.com/AmazonS3/latest/userguide/website-hosting-custom-domain-walkthrough.html

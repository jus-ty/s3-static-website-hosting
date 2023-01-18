resource "aws_s3_bucket" "website_bucket" {
    bucket  = var.website_hosting_bucket_name
    tags    = var.website_hosting_bucket_tags
}

resource "aws_s3_bucket" "website_subdomain_bucket" {
    bucket  = "www.${var.website_hosting_bucket_name}"
    tags    = var.website_hosting_bucket_tags
}

resource "aws_s3_bucket" "website_logging_bucket" {
    bucket  = "${var.website_hosting_bucket_name}-logging-bucket"
    tags    = var.website_hosting_bucket_tags
}

resource "aws_s3_bucket_acl" "website_bucket_acl" {
    bucket  = aws_s3_bucket.website_bucket.id
    acl     = "public-read"
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
    bucket  = aws_s3_bucket.website_bucket.id
    policy  = data.aws_iam_policy_document.allow_get_object_public.json
}

data "aws_iam_policy_document" "allow_get_object_public" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.website_bucket.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_website_configuration" "website_bucket_configuration" {
    bucket = aws_s3_bucket.website_bucket.bucket

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }
}

resource "aws_s3_bucket_logging" "server_access_logging" {
  bucket = aws_s3_bucket.website_bucket.id
  target_bucket = aws_s3_bucket.website_logging_bucket.id
  target_prefix = "log/"
}

#########################
resource "aws_s3_bucket_policy" "logging_bucket_policy" {
    bucket  = aws_s3_bucket.website_logging_bucket.id
    policy  = data.aws_iam_policy_document.logging_bucket_allow_logs.json
}

data "aws_iam_policy_document" "logging_bucket_allow_logs" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "${aws_s3_bucket.website_logging_bucket.arn}/*"
    ]
  }
}
######################

resource "aws_s3_bucket_website_configuration" "subdomain_bucket_configuration" {
    bucket = aws_s3_bucket.website_subdomain_bucket.bucket

    redirect_all_requests_to {
        host_name = var.website_hosting_bucket_name
        protocol = "http"
    }
}

resource "aws_s3_bucket_object" "website_contents_html" {
    for_each      = fileset("../src/html/", "*")
    bucket        = aws_s3_bucket.website_bucket.id
    key           = each.value
    source        = "../src/html/${each.value}"
    etag          = filemd5("../src/html/${each.value}")
    content_type  = "text/html"
}

locals {
    info_tags = "${merge(var.generic_tags, {"Branch": "${var.git_branch}"}, {"Project": "${var.bucket_name}"})}"
}
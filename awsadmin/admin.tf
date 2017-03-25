terraform {
    backend "s3" {
        bucket = "slackjukebox"
        key    = "admin/terraform.tfstate"
    }
}

resource "aws_iam_user" "slackjukebox" {
  name = "slackjukebox"
  path = "/"
}

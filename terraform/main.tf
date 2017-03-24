terraform {
    backend "s3" {
        bucket = "slackjukebox"
        key    = "terraform.tfstate"
        region = "eu-west-1"
    }
}

resource "aws_iam_user" "slackjukebox" {
  name = "slackjukebox"
  path = "/"
}

terraform {
    backend "s3" {
        bucket = "slackjukebox"
        key    = "resources/terraform.tfstate"
    }
}

provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_dynamodb_table" "slackjukebox" {
  name = "slackjukebox"
  read_capacity  = 5
  write_capacity = 5
  hash_key = "PlayListId"

  attribute {
    name = "PlayListId"
    type = "S"
  }

  tags {
    Name = "slackjukebox"
  }
}

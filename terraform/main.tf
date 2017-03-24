terraform {
    backend "s3" {
        bucket = "slackjukebox"
        key    = "resources/terraform.tfstate"
    }
}

resource "aws_api_gateway_rest_api" "rest-api" {
  name = "slackjukebox Endpoint"
  description = "Endpoint for HTTPS Slack webhook"
}

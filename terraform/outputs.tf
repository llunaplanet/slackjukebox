output "api_endpoint" {
    value = "https://${aws_api_gateway_rest_api.slack_jukebox_api.id}.execute-api.${var.aws_region}.amazonaws.com/"
}

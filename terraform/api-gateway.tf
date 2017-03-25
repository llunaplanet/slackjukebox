# Create a resource

resource "aws_api_gateway_rest_api" "slack_jukebox_api" {
  name = "slackJukeboxApiEndpoint"
  description = "Endpoint for HTTPS Slack webhook"
}

resource "aws_api_gateway_resource" "slack_endpoint" {
  rest_api_id = "${aws_api_gateway_rest_api.slack_jukebox_api.id}"
  parent_id = "${aws_api_gateway_rest_api.slack_jukebox_api.root_resource_id}"
  path_part = "slack"
}

# Call the module to attach a method along with its request/response/integration templates
# This one creates a user.

module "slack_post" {
  source  = "./api_gateway_resource"
  rest_api_id = "${aws_api_gateway_rest_api.slack_jukebox_api.id}"
  resource_id = "${aws_api_gateway_resource.slack_endpoint.id}"
  resource_path = "${aws_api_gateway_resource.slack_endpoint.path}"
  http_method = "GET"
  lambda_name = "hello_world"
  account_id = "${data.aws_caller_identity.current.account_id}"
  region = "${var.aws_region}"

   depends_on = [
       "aws_lambda_function.hello_world"
   ]
}

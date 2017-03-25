# Create a resource

resource "aws_api_gateway_rest_api" "jukeboxapi" {
  name = "slackjukeboxapi Endpoint"
  description = "Endpoint for HTTPS Slack webhook"
}

resource "aws_api_gateway_resource" "slack" {
  rest_api_id = "${aws_api_gateway_rest_api.jukeboxapi.id}"
  parent_id = "${aws_api_gateway_rest_api.jukeboxapi.root_resource_id}"
  path_part = "slack"
}

# Call the module to attach a method along with its request/response/integration templates
# This one creates a user.

module "UsersPost" {
  source  = "github.com/carrot/terraform-api-gateway-method-module"
  rest_api_id = "${aws_api_gateway_rest_api.jukeboxapi.id}"
  resource_id = "${aws_api_gateway_resource.slack.id}"
  http_method = "GET"
  lambda_name = "create_user_lambda_funciton"
  account_id = "${data.aws_caller_identity.current.account_id}"
  region = "us-west-1"
  integration_request_template = "#set($inputRoot = $input.path('$')){}"
  request_model = "Empty"
  integration_response_template = "#set($inputRoot = $input.path('$')){}"
  response_model = "Empty"
  integration_error_template = "#set ($errorMessageObj = $util.parseJson($input.path('$.errorMessage')) {\"message\" :\"$errorMessageObj.message\"}"
  authorization = "NONE"
}

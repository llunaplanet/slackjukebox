resource "aws_api_gateway_method" "resource_method" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${var.http_method}"
  authorization = "${var.authorization}"
}

resource "aws_api_gateway_integration" "resource_method_integration" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_method.resource_method.http_method}"
  type = "AWS"
  uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${var.account_id}:function:${var.lambda_name}/invocations"
  integration_http_method = "POST"
}

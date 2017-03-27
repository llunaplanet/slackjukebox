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

resource "aws_api_gateway_method_response" "resource_method_200" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_method.resource_method.http_method}"
  status_code = "200"
  #response_models = { "application/json" = "${var.response_model}" }
  #response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "*" }
}

resource "aws_api_gateway_integration_response" "resource_method_integration_200" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_method.resource_method.http_method}"
  status_code = "${aws_api_gateway_method_response.resource_method_200.status_code}"
  #response_parameters = {
    #"method.response.header.Access-Control-Allow-Origin" = "'*'"
  #}
  #response_templates = { "application/json" = "${var.integration_response_template}" }
  depends_on = [
      "aws_api_gateway_integration.resource_method_integration"
  ]
}

resource "aws_lambda_permission" "allow-api-gateway-to-call-get" {
    function_name = "${var.lambda_name}"
    statement_id = "allow-api-gateway-to-call-get"
    action = "lambda:InvokeFunction"
    principal = "apigateway.amazonaws.com"
    source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${var.rest_api_id}/*/${var.http_method}${var.resource_path}"
}

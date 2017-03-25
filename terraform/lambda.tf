resource "aws_lambda_permission" "allow-api-gateway-parent-resource-get" {
    function_name = "${var.aws-lambda-function-name}"
    statement_id = "allow-api-gateway-parent-resource-get"
    action = "lambda:InvokeFunction"
    principal = "apigateway.amazonaws.com"
    source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.rest-api.id}/*/${aws_api_gateway_method.parent-resource-method-get.http_method}${aws_api_gateway_resource.parent-resource.path}"
}

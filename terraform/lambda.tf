data "aws_caller_identity" "current" {}

data "archive_file" "lambda_code_zip" {
    type = "zip"
    source_dir = "${path.module}/../lambda"
    output_path = "${path.module}/../files/lambda_code.zip"
}

resource "aws_lambda_function" "hello_world" {
    filename = "${path.module}/../files/lambda_code.zip"
    function_name = "hello_world"
    role = "${var.iam_for_lambda}"
    handler = "index.handler"
    source_code_hash = "${data.archive_file.lambda_code_zip.output_base64sha256}"
    timeout = 120
    runtime = "node6.10"
    environment {
        variables = {
            DB_NAME = "${aws_dynamodb_table.slackjukebox.name}"
        }
    }
}

resource "aws_lambda_permission" "allow-api-gateway-to-call-get" {
    function_name = "${var.aws_lambda_function_name}"
    statement_id = "allow-api-gateway-parent-resource-get"
    action = "lambda:InvokeFunction"
    principal = "apigateway.amazonaws.com"
    source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.rest-api.id}/*/${aws_api_gateway_method.parent-resource-method-get.http_method}${aws_api_gateway_resource.parent-resource.path}"
}

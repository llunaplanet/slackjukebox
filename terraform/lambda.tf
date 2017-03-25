data "aws_caller_identity" "current" {}

data "archive_file" "lambda_code_zip" {
    type = "zip"
    source_dir = "${path.module}/../lambda"
    output_path = "${path.module}/../files/lambda_code.zip"
}

resource "aws_lambda_function" "hello_world" {
    filename = "${path.module}/../files/lambda_code.zip"
    function_name = "hello_world"
    role = "${aws_iam_role.iam_role_for_lambda.id}"
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

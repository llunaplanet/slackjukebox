data "aws_iam_policy_document" "aws_iam_role" {

  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
        type = "Service"
        identifiers = ["lambda.amazonaws.com"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
        "cloudwatch:*",
        "events:*",
        "lambda:*",
        "logs:*",
        "s3:*"
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role" "iam_role_for_lambda" {
    name = "iam_role_for_slackjukebox_lambda"
    assume_role_policy = "${data.aws_iam_policy_document.aws_iam_role.json}"
}

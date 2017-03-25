data "aws_iam_policy_document" "aws_iam_role" {

  statement {
    effect = "allow"
    actions = ["sts:AssumeRole"]
    principals {
        type = "Service"
        identifiers = ["lambda.amazonaws.com"]
    }
  }

  statement {
    effect = "allow"
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
    assume_role_policy = "${aws_iam_policy_document.aws_iam_role.json}"
}

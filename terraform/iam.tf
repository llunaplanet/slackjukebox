resource "aws_iam_role" "iam_role_for_lambda" {
    name = "iam_role_for_slackjukebox_lambda"
    assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": {
        "Effect": "Allow",
        "Principal": {"Service": "lambda.amazonaws.com"},
        "Action": "sts:AssumeRole"
      }
    }
    EOF
}

resource "aws_iam_role_policy" "lambda_exec_role" {
    name = "lambda_exec_role"
    role = "${aws_iam_role.iam_role_for_lambda.id}"
    policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "cloudwatch:*",
            "events:*",
            "lambda:*",
            "logs:*",
            "s3:*"
          ],
          "Resource": "*"
        }
      ]
    }
    EOF
}

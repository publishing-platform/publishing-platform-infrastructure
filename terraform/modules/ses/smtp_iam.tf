resource "aws_iam_user" "smtp" {
  name = "publishing-platform-smtp"
}

resource "aws_iam_access_key" "smtp" {
  user = aws_iam_user.smtp.name
}

data "aws_iam_policy_document" "ses_sender" {
  statement {
    effect = "Allow"
    actions = [
      "ses:SendEmail",
      "ses:SendRawEmail"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ses_sender" {
  name        = "ses_sender"
  description = "Allows sending of e-mails via Simple Email Service"
  policy      = data.aws_iam_policy_document.ses_sender.json
}

resource "aws_iam_user_policy_attachment" "ses_sender" {
  user       = aws_iam_user.smtp.name
  policy_arn = aws_iam_policy.ses_sender.arn
}
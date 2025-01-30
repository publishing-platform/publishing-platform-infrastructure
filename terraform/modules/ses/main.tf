resource "aws_ses_domain_identity" "domain_identity" {
  domain = var.domain_name
}

resource "aws_ses_domain_dkim" "dkim_identity" {
  domain = aws_ses_domain_identity.domain_identity.domain
}

// this resource depends on DKIM records being added to DNS so will fail until these have been added
resource "aws_ses_domain_identity_verification" "domain_identity_verification" {
  domain = aws_ses_domain_identity.domain_identity.id
}
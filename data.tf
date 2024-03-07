data "aws_acm_certificate" "jenkins" {
  domain = var.jenkins_master_domain
}

resource "aws_kms_key" "efs_kms_key" {
  description             = "KMS key RiskTech EFS"
  deletion_window_in_days = 10  
}

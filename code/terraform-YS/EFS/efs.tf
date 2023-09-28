# resource "aws_efs_file_system" "efs" {
# #   count = local.environment == "non-prod" ? 1 : 0
#   tags = {
#     Name = "sandbox-efs"
#   }
# }

# resource "aws_efs_mount_target" "efs_mount_targets" {
# #   for_each        = local.environment == "non-prod" ? toset(local.subnet_ids) : []
#   file_system_id  = one(aws_efs_file_system.efs.*.id)
#   subnet_id       = each.value
#   security_groups = aws_security_group.efs_security_group.*.id
# }

# resource "aws_security_group" "efs_security_group" {
# #   count = local.environment == "non-prod" ? 1 : 0
#   name        = "sandbox-efs"
#   description = "Allow qtp dev eks inbound traffic"
# #   vpc_id      = local.vpc_id

#   ingress {
#     description = "Sandbox EC2 access"
#     from_port   = 2049
#     to_port     = 2049
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "sandbox-efs"
#   }
# }

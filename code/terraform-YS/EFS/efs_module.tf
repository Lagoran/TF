
# This the public AWS EFS TF module - https://registry.terraform.io/modules/terraform-aws-modules/efs/aws/latest

module "efs" {
  source = "terraform-aws-modules/efs/aws"

  # File system
  name           = "efs_sandbox"
  creation_token = "EFS-sandbox-prod-token"
  encrypted      = true
  kms_key_arn    = aws_kms_key.efs_kms_key.arn

  performance_mode                = "generalPurpose"
  throughput_mode                 = "provisioned"
  provisioned_throughput_in_mibps = 256

  lifecycle_policy = {
    transition_to_ia = "AFTER_30_DAYS"
  }

  # File system policy
  attach_policy                      = true
  bypass_policy_lockout_safety_check = false
  policy_statements = [
    {
      sid     = "efs-sandbox-policy"
      actions = ["*"]
      principals = [
        {
          type        = "AWS"
          identifiers = ["*"]
          #identifiers = ["arn:aws:iam::084160361108:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_rAppAdmins_26bd55710366ab3c"]
        }
      ]
      resources = ["arn:aws:elasticfilesystem:us-east-1:610162518049:file-system/fs-08ed8acf2b24a0d39"]      
    }
  ]

  # Mount targets / security group
  mount_targets = {
    "us-east-1b" = {
      subnet_id = "subnet-093d981bd0e1e1e2b"
    }
    "us-east-1c" = {
      subnet_id = "subnet-0aba18d4953a2cd1c"
    }
    "us-east-1e" = {
      subnet_id = "subnet-0f5586a1c0ed8ba5e"
    }
    "us-east-1a" = {
      subnet_id = "subnet-03e0ccabbb6baba38"
    }
    "us-east-1f" = {
      subnet_id = "subnet-0437cd2481697c25a"
    }
    "us-east-1d" = {
      subnet_id = "subnet-0cf4e828658618f5b"
    }
  }
  security_group_description = "EFS-sandbox security group"
  security_group_vpc_id      = "vpc-03baf630bcaac0124"
  security_group_rules = {
    vpc = {
      # relying on the defaults provdied for EFS/NFS (2049/TCP + ingress)
      description = "NFS ingress from VPC private subnets"
      cidr_blocks = ["172.31.0.0/16"]
    }
  }

  # Access point(s)
  access_points = {
    posix_example = {
      name = "posix-example"
      posix_user = {
        gid            = 1001
        uid            = 1001
        secondary_gids = [1002]
      }

      tags = {
        Additionl = "yes"
      }
    }
    root_example = {
      root_directory = {
        path = "/example"
        creation_info = {
          owner_gid   = 1001
          owner_uid   = 1001
          permissions = "755"
        }
      }
    }
  }

  # Backup policy
  enable_backup_policy = true

  # Replication configuration
  create_replication_configuration = true
  replication_configuration_destination = {
    region = "us-east-1"
  }

  tags = {
    Terraform   = "true"
    Environment = "prod"
    Name        = "EFS"
    Owner       = "sandbox"
    Purpose     = "sandbox EFS"
  }
}



# # This the public AWS EFS TF module - https://registry.terraform.io/modules/terraform-aws-modules/efs/aws/latest

# module "efs" {
#   source = "terraform-aws-modules/efs/aws"

#   # File system
#   name           = "efs-sandbox"
#   creation_token = "efs-sandbox-token"
#   encrypted      = true

#   performance_mode                = "generalPurpose"
#   throughput_mode                 = "provisioned"
#   provisioned_throughput_in_mibps = 30

#   lifecycle_policy = {
#     transition_to_ia = "AFTER_30_DAYS"
#   }

#   # File system policy
#   attach_policy                      = true
#   bypass_policy_lockout_safety_check = false
#   policy_statements = [
#     {
#       sid     = "efs-sandbox-policy"
#       actions = ["*"]
#       principals = [
#         {
#           type        = "AWS"
#           identifiers = ["*"]
#           #identifiers = ["arn:aws:iam::084160361108:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_rAppAdmins_26bd55710366ab3c"]
#         }
#       ]
#       resources = ["arn:aws:elasticfilesystem:us-east-1:610162518049:file-system/*"]      
#     }
#   ]

#   # Mount targets / security group
#   mount_targets = lookup(local.efs_mount_targets, local.environment)
  
#   security_group_description = "efs-sandbox_security_group"
#   security_group_vpc_id      = lookup(local.aws_vpc, local.environment)

#   security_group_rules = {
#     vpc = {
#       # relying on the defaults provdied for EFS/NFS (2049/TCP + ingress)
#       description = "NFS ingress from VPC private subnets"
#       cidr_blocks = lookup(local.aws_private_subnets, local.environment)
#     }
#   }

#   # Access point(s)
#   access_points = {
#     posix_example = {
#       name = "posix-example"
#       posix_user = {
#         gid            = 50009
#         uid            = 50009
#       }

#       tags = {
#         Additionl = "yes"
#       }
#     }
#     root_example = {
#       root_directory = {
#         path = "/example"
#         creation_info = {
#           owner_gid   = 50009
#           owner_uid   = 50009
#           permissions = "755"
#         }
#       }
#     }
#   }

#   # Backup policy
#   enable_backup_policy = true

#   # Replication configuration
#   create_replication_configuration = false

#   tags = {
#     Terraform   = "true"
#     Environment = "sandbox"
#     Name        = "EFS"
#     Owner       = "Sandbox"
#     Purpose     = "EFS_test"
#   }
# }

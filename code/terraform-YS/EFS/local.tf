locals {
  efs_arn                    = "arn:aws:elasticfilesystem:us-east-1:107218933953:file-system/fs-0aa243cf7ebaf4592"
  security_group_vpc_id      = "vpc-0ed9a35c213f20938"
  subnet_id_us-east-1a       = "subnet-05ee34d9023477dcd"
  subnet_id_us-east-1b       = "subnet-040a5549f11bd784f"
  subnet_id_us-east-1c       = "subnet-0196b072b06961997"
  subnet_id_us-east-1d       = "subnet-0f9cc3096051ddb72"
  subnet_id_us-east-1e       = "subnet-0c545ef87c2239fb8"
  subnet_id_us-east-1f       = "subnet-0013b87207c55bd9d"
  default_security_group_id  = "sg-0ba4d5c358cc5dbd1"
}

#For cort testing
# locals {
#   providers = {
#     "non-prod"   = "arn:aws:iam::479071245824:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/BE4F55D6E8D55ABB138A245A6A21F3B8"
#     "uat"        = ""
#     "production" = "arn:aws:iam::084160361108:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/8ADF27D37528D597DEFD42B03507D7DF"
#   }
#   efs_mount_targets = {
#     non-prod   = {
#         "us-east-1a" = {
#           subnet_id = "subnet-0fd1356bc53a500d2"
#       }
#         "us-east-1b" = {
#           subnet_id = "subnet-0a8718c1af7ba7724"
#       }
#         "us-east-1c" = {
#           subnet_id = "subnet-0fb8bda0e7681fcbf"
#       } 
#     }
#     uat        = []
#     # production = {
#     #     "us-east-1b" = {
#     #       subnet_id = "subnet-05cc63ac3a94bd459"
#     #   }
#     #     "us-east-1d" = {
#     #       subnet_id = "subnet-0572c40e194623621"
#     #   }
#     #     "us-east-1c" = {
#     #       subnet_id = "subnet-0a3df777a74e6a678"
#     #   } 
#     # }
#   }
#   aws_vpc = {
#     non-prod   = "vpc-0ed9a35c213f20938"
#     uat        = ""
#     # production = "vpc-0c0ee1de2fee171a2"
#   }
#   aws_private_subnets = {
#     non-prod   = ["10.74.68.128/26", "10.74.68.192/26", "10.74.69.0/26"]
#     uat        = []
#     # production = ["10.0.0.0/8"]

#   }
#   subnets = {
#     non-prod   = []
#     uat        = []
#     production = ["subnet-05cc63ac3a94bd459","subnet-0572c40e194623621","subnet-0a3df777a74e6a678"]
#   }
#   # node_type = {
#   #   non-prod   = "cache.t2.small"
#   #   uat        = "cache.t2.small"
#   #   production = "cache.r5.xlarge"
#   # }
#   num_node_groups = {
#     non-prod   = 1
#     uat        = 1
#     production = 1
#   }
#   replicas_per_node_group = {
#     non-prod   = 1
#     uat        = 1
#     production = 1
#   }
#   automatic_failover = {
#     non-prod   = true
#     uat        = true
#     production = true
#   }
#   snapshot_retention_limit = {
#     non-prod   = 1
#     uat        = 1
#     production = 1
#   }
# }

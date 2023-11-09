locals {
  access_key = "AKIA2HGFCP7K4GVKT6FZ"
  secret_key = "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"
  region                     = "us-east-1"

  security_group_vpc_id      = "vpc-0199c31e396651aea"
  default_security_group_id  = "sg-0190522f86b153e50"   
  efs_arn                    = "arn:aws:elasticfilesystem:us-east-1:702640455637:file-system/fs-012a484adea502956"
 
  subnet_id_us-east-1a       = "subnet-02cb0e187ba115088"
  subnet_id_us-east-1b       = "subnet-0492546f8c8abe492"
  subnet_id_us-east-1c       = "subnet-087e32941f5357b33"
  subnet_id_us-east-1d       = "subnet-0407a60b569136352"
  subnet_id_us-east-1e       = "subnet-0cbf9415520a25557"
  subnet_id_us-east-1f       = "subnet-0f4fb93c13563e288"

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

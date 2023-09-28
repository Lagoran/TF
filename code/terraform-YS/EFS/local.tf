locals {
  providers = {
    "non-prod"   = "arn:aws:iam::479071245824:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/BE4F55D6E8D55ABB138A245A6A21F3B8"
    "uat"        = ""
    "production" = "arn:aws:iam::084160361108:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/8ADF27D37528D597DEFD42B03507D7DF"
  }
  efs_mount_targets = {
    non-prod   = {
        "us-east-1a" = {
          subnet_id = "subnet-0fd1356bc53a500d2"
      }
        "us-east-1b" = {
          subnet_id = "subnet-0a8718c1af7ba7724"
      }
        "us-east-1c" = {
          subnet_id = "subnet-0fb8bda0e7681fcbf"
      } 
    }
    uat        = []
    # production = {
    #     "us-east-1b" = {
    #       subnet_id = "subnet-05cc63ac3a94bd459"
    #   }
    #     "us-east-1d" = {
    #       subnet_id = "subnet-0572c40e194623621"
    #   }
    #     "us-east-1c" = {
    #       subnet_id = "subnet-0a3df777a74e6a678"
    #   } 
    # }
  }
  aws_vpc = {
    non-prod   = "vpc-0b56f09855aa79130"
    uat        = ""
    # production = "vpc-0c0ee1de2fee171a2"
  }
  aws_private_subnets = {
    non-prod   = ["10.74.68.128/26", "10.74.68.192/26", "10.74.69.0/26"]
    uat        = []
    # production = ["10.0.0.0/8"]

  }
  subnets = {
    non-prod   = []
    uat        = []
    production = ["subnet-05cc63ac3a94bd459","subnet-0572c40e194623621","subnet-0a3df777a74e6a678"]
  }
  # node_type = {
  #   non-prod   = "cache.t2.small"
  #   uat        = "cache.t2.small"
  #   production = "cache.r5.xlarge"
  # }
  num_node_groups = {
    non-prod   = 1
    uat        = 1
    production = 1
  }
  replicas_per_node_group = {
    non-prod   = 1
    uat        = 1
    production = 1
  }
  automatic_failover = {
    non-prod   = true
    uat        = true
    production = true
  }
  snapshot_retention_limit = {
    non-prod   = 1
    uat        = 1
    production = 1
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "environment" {
  description = "The name of the environment we're deploying to"
  type        = string
  default     = "dev"
  
  validation {
    condition = contains (["dev", "uat", "prod"], var.environment)
    error_message = ">>>Only 3 type of environemnt are allowed to be chosen: dev | uat | prod.<<<"
  }  
}

variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
  default     = 1

  validation {
    condition = var.min_size > 0
    error_message = ">>>ASGs can't be empty!!<<<"
  }

  validation {
    condition = var.min_size < 20
    error_message = ">>>ASGs must have lower min value!!<<<"
  }  
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
  default     = 1

  validation {
    condition = var.max_size > 0
    error_message = ">>>ASGs can't be empty!!<<<"
  }

  validation {
    condition = var.max_size < 22
    error_message = ">>>ASGs must have higher min value!!<<<"
  }    
}

variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
  type        = bool
  default     = true
}


# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "ami" {
  description   = "The AMI to run in the cluster"
  type          = string
  default       = "ami-022e1a32d3f742bd8"
  
}

variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
  type        = string
  default     = "t2.micro"
}

variable "server_text" {
  description = "The text the web server should return"
  default     = "Hello, World!!"
  type        = string
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}

variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type        = map(string)
  default     = {
    name      = "Yordan Strahinov"
    purpose   = "dev"
  }
}

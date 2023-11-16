module "users" {
  source = "../../../modules/landing-zone/iam-user"

  count     = length(var.user_names)
  user_name = var.user_names[count.index]     #Note that after you’ve used count on a resource, it becomes an array of resources rather than just one resource. Because aws_iam_user.example is now an array of IAM users, instead of using the standard syntax to read an attribute from that resource (<PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>), you must specify which IAM user you’re interested in by specifying its index in the array using the same array lookup syntax: <PROVIDER>_<TYPE>.<NAME>[INDEX].ATTRIBUTE
}

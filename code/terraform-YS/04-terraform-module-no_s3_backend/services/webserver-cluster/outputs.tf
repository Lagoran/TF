output "alb_dns_name" {
  value         = module.webserver_cluster.alb_dns_name
  description   = "The domain name of the load balancer"
}

output "alb_security_group_id" {
  value         = module.webserver_cluster.alb_security_group_id
  description   = "The ID of the Security Group attached to the Load balancer"
  
}

output "asg_name" {
  value         = module.webserver_cluster.asg_name
  description   = "The name of the Auto Scaling Group"
}

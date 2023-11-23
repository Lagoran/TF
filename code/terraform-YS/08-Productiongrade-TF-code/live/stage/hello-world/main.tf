module "hello_world_app" {
  # TODO: replace this with your own module URL and version!!
  source = "../../../small-modules/examples/services/hello-world-app"

  server_text            = "New server text"
  environment            = "dev"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false
}

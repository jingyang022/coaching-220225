module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.9.0"

  cluster_name = "multiservice"


  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 100
      }
    }
  }

  services = {
    s3-service = {
    cpu    = 512
      memory = 1024

      container_definitions = {
        s3-service = { #container name -> Change
          essential = true
          image     = "arn:aws:ecr:ap-southeast-1:255945442255:repository/wx-sqs"
          port_mappings = [
            {
              containerPort = 8080
              protocol      = "tcp"
            }
          ]
        }
       sqs-service = { #container name -> Change
          essential = false
          image     = "arn:aws:ecr:ap-southeast-1:255945442255:repository/wx-s3"
          port_mappings = [
            {
              containerPort = 8080
              protocol      = "tcp"
            }
          ]
        }
      } 
    }
  }
}
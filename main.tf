terraform {
   required_providers {
     terratowns = {
       source = "local.providers/local/terratowns"
       version = "1.0.0"
     }
   }
#   backend "remote" {
#     hostname = "app.terraform.io"
#     organization = "ozararichard"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }
# }
    cloud {
      organization = "ozararichard"
      workspaces {
        name = "terra-house-1"
    }
  }
  
}    

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token=var.terratowns_access_token
  
}
module "home_arcanum_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.arcanum.public_path
  content_version = var.arcanum.content_version
}

resource "terratowns_home" "home" {
  name = " Vechicle Dashcam in 2023!"
  description = <<DESCRIPTION
A space to point to best dashcams in 2023. 
DESCRIPTION
  domain_name = module.home_arcanum_hosting.domain_name
  town = "video-valley"
  content_version = var.arcanum.content_version
}

module "home_payday_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.payday.public_path
  content_version = var.payday.content_version
}

resource "terratowns_home" "home_payday" {
  name = " Something to find in 2023!"
  description = <<DESCRIPTION
Aspire to climb as high as you can dream. 
DESCRIPTION
  domain_name =  module.home_payday_hosting.domain_name
  town = "the-nomad-pad"
  content_version = var.payday.content_version
}

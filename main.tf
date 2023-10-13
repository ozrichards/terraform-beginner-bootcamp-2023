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
#     cloud {
#       organization = "ozararichard"
#       workspaces {
#         name = "terra-house-1"
#     }
#   }
  
}    

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token=var.terratowns_access_token
  
}
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  assets_path = var.assets_path
  content_version = var.content_version
}

resource "terratowns_home" "home" {
  name = " Vechicle Dashcam in 2023!"
  description = <<DESCRIPTION
A space to point to best dashcams in 2023. 
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "3fd32oq3gz.cloudfront.net"
  town = "missingo"
  content_version = 1
}

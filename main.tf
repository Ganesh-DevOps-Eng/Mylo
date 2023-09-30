module "RDS-Module" {
  source                    = "./RDS-Module"
  project_name              = var.project_name
  vpc_cidr                  = var.vpc_cidr
  instance_type             = var.instance_type
  subject_alternative_names = var.subject_alternative_names
  ami_id                    = var.ami_id
  root_domain_name          = var.root_domain_name
  environment               = var.environment
  az_count                  = var.az_count
  alb_a_record              = var.alb_a_record


  lifecycle {
    prevent_destroy = true
  }
}

module "S3-Module" {
  source       = "./S3-Module"
  region       = var.region
  project_name = var.project_name
  bucket_name  = var.bucket_name
  key          = module.RDS-Module.my_key_pair

  lifecycle {
    prevent_destroy = true
  }
}
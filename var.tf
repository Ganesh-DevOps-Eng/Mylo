#RDS module
variable "environment" {}


#vpc module

variable "project_name" {}
variable "vpc_cidr" {}
variable "az_count" {}

#key module

variable "ami_id" {}
variable "instance_type" {}

#root53 domin

variable "root_domain_name" {}
variable "subject_alternative_names" { type = list(string) }
variable "alb_a_record" {}

# s3 module
variable "bucket_name" {}
variable "region" {}


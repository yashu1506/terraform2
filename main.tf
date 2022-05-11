provider "aws" {
    region = "us-east-1"
    access_key = "AKIAZSBWQT4VQTR432GC"
    secret_key = "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"
}
module "vpc_1" {
    source = "../modules/vpc"
    vpc_cidr = "192.162.0.0/16"
    tenancy = "default"
    vpc_id = "${module.vpc_1.vpc_id}"
    subnet_cidr = "192.162.1.0/24"
}

module "ec2_1" {
    source = "../modules/ec2"
    ec2_count = 1
    ami_id = "ami-09d56f8956ab235b3"
    instance_type = "t2.micro"
    subnet_id = "${module.vpc_1.subnet_id}"
}

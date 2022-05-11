provider "aws" {
    region = "us-east-1"
    aws_access_key = "AKIAZSBWQT4VQTR432GC"
    aws_secret_key = "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"
}
module "my_vpc" {
    source = "./modules/vpc"
    vpc_cidr = "192.168.0.0/16"
    tenancy = "default"
    vpc_id = "${module.my_vpc.vpc_id}"
    subnet_cidr = "192.168.1.0/24"
}

module "my_ec2" {
    source = "./modules/ec2"
    ec2_count = 1
    ami_id = "ami-09d56f8956ab235b3"
    instance_type = "t2.micro"
    subnet_id = "${module.my_vpc.subnet_id}"
}

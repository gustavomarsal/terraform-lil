resource "google_compute_network" "our_development_network" {
  name = "devnetwork"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "dev-subnet" {
  ip_cidr_range = "10.0.1.0/24"
  name = "devsubnet"
  network = "${google_compute_network.our_development_network.self_link}"
  region = "southamerica-east1"
}

resource "aws_vpc" "environment-example-two" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags {
    Name = "terraform-aws-vpc-example-two"
  }
}

resource "aws_subnet" "subnet1" {
  cidr_block = "${cidrsubnet(aws_vpc.environment-example-two.cidr_block,3 ,1 )}"
  vpc_id = "${aws_vpc.environment-example-two.id}"
  availability_zone = "sa-east-1a"
}

resource "aws_subnet" "subnet2" {
  cidr_block = "${cidrsubnet(aws_vpc.environment-example-two.cidr_block,2 ,2 )}"
  vpc_id = "${aws_vpc.environment-example-two.id}"
  availability_zone = "sa-east-1c"
}

resource "aws_security_group" "subnetsecurity" {
  vpc_id = "${aws_vpc.environment-example-two.id}"

  ingress {
   cidr_blocks = [
      "${aws_vpc.environment-example-two.cidr_block}"
   ]

    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
}

resource "azurerm_resource_group" "azy_network" {
  location = "Brazil South "
  name = "devresgrp"
}

resource "azurerm_virtual_network" "blue_virtual_network" {
  address_space = ["10.0.0.0/16"]
  location = "Brazil South"
  name = "bluevirtnetwork"
  resource_group_name = "${azurerm_resource_group.azy_network.name}"
  dns_servers = ["10.0.0.4","10.0.0.5"]

  subnet {
    address_prefix = "10.0.1.0/24"
    name = "subnet1"
  }

  subnet {
    address_prefix = "10.0.2.0/24"
    name = "subnet2"
  }

  tags {
    enviroment = "blue-world-finder"
  }
}

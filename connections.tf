provider "google" {
  credentials = "${file("../account.json")}"
  project = "annular-beacon-183621"
  region = "southamerica-east1-a"
}

provider "aws" {
  region = "sa-east-1"
}

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id = "${var.client_id}"
  client_secret = "${var.secret}"
  tenant_id = "${var.tenant_id}"
}

variable "subscription_id" {}
variable "client_id" {}
variable "secret" {}
variable "tenant_id" {}
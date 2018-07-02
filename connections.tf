provider "google" {
  credentials = "${file("../account.json")}"
  project = "annular-beacon-183621"
  region = "southamerica-east1-a"
}

provider "aws" {
  region = "sa-east-1"
}

provider "azurerm" {
  subscription_id = "0"
  client_id = "1"
  client_secret = "2"
  tenant_id = "3"
}
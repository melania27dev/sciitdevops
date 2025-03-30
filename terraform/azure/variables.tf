# variable "location" {
#   description = "Azure region for resources"
#   type        = string
#   default     = "West Europe"
# }

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "devops"
}

variable "prefix" {
  type        = string
  default     = "win-vm-iis"
  description = "Prefix of the resource name"
}

variable "resource_group_location" {
  type        = string
  default     = "East US"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "devadmin"
}

# variable "region" {
#   description = "The AWS region to deploy resources in"
#   type        = string
#   default     = "eu-west-1"
# }
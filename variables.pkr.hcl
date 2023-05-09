variable "client_id" {
  description = "The ID of the Service Principal used to build the Azure VM Image"
  type        = string
}

variable "client_secret" {
  description = "The secret of the Service Principal used to build the Azure VM Image"
  type        = string
}

variable "compute_gallary_name" {
  description = "The name of the Azure Compute Gallary where the Azure VM Image will be stored"
  type        = string
}

variable "image_name_prefix" {
  default     = "img-devbox"
  description = "A prefix to use for the Azure VM Image name"
}

variable "location" {
  default     = "UK South"
  description = "The Azure region where the VM Image will be created and stored"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group where the Azure VM Image will be stored"
  type        = string
}

variable "subscription_id" {
  description = "The ID of the Azure Subscription containing the Service Principal used to build the Azure VM Image"
  type        = string
}

variable "tenant_id" {
  description = "The ID of the Azure Tenant containing the Service Princpal used to build the Azure VM Image"
  type        = string
}

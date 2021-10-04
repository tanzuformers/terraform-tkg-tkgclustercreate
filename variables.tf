variable "files_path" {
    type = string
    description = "Path of the input/output values"
    default = "."
}
variable "tkg_vault_ip" {
    type = string
    description = "Vault server ip"
}
variable "cluster_name" {
  type = string
  description = "Cluster Name"
}
variable "cluster_management_ip" {
  type = string
  description = "Cluster Management IP"
}


output "result" {
  description = "Path where kubectl file is located"
  value = "${var.files_path}/kubeconfig-${var.cluster_name}"
}
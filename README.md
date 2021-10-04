This module is a part of tkg modules and requires:
- management cluster deployment with vault system 
The output of the module is a kubectl file (the same file will be stored in vault)
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_sshclient"></a> [sshclient](#requirement\_sshclient) | 1.0.1 |
| <a name="requirement_sshcommand"></a> [sshcommand](#requirement\_sshcommand) | 0.2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_sshclient"></a> [sshclient](#provider\_sshclient) | 1.0.1 |
| <a name="provider_sshcommand"></a> [sshcommand](#provider\_sshcommand) | 0.2.2 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |
| <a name="provider_vault"></a> [vault](#provider\_vault) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.get_kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.create_cluster](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [sshclient_scp_put.bootvm_tpl_clsuter](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/resources/scp_put) | resource |
| [vault_generic_secret.vault_secret_cluster_kube](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |
| [local_file.vault_root_token](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [sshclient_host.bootvm_keyscan](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/data-sources/host) | data source |
| [sshclient_host.bootvm_main](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/data-sources/host) | data source |
| [sshclient_keyscan.bootvm](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/data-sources/keyscan) | data source |
| [sshcommand_command.generate_kubectl](https://registry.terraform.io/providers/invidian/sshcommand/0.2.2/docs/data-sources/command) | data source |
| [sshcommand_command.get_kubectl](https://registry.terraform.io/providers/invidian/sshcommand/0.2.2/docs/data-sources/command) | data source |
| [template_file.tkg-cluster-template](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [vault_generic_secret.bootvm](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.mgmt_cluster](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.tkg_env](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.vsphere_env](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_management_ip"></a> [cluster\_management\_ip](#input\_cluster\_management\_ip) | Cluster Management IP | `any` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster Name | `any` | n/a | yes |
| <a name="input_files_path"></a> [files\_path](#input\_files\_path) | Path of the input/output values | `string` | `"."` | no |
| <a name="input_tkg_vault_ip"></a> [tkg\_vault\_ip](#input\_tkg\_vault\_ip) | Vault server ip | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_result"></a> [result](#output\_result) | Path where kubectl file is located |
<!-- END_TF_DOCS -->

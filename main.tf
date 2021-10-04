terraform {
  required_providers {
    sshcommand = {
      source  = "invidian/sshcommand"
      version = "0.2.2"
    }
    sshclient = {
      source  = "luma-planet/sshclient"
      version = "1.0.1"
    }
  }
}
provider "vault" {
  address = "http://${var.tkg_vault_ip}:8200"
  token = local.vault_root_token
}


data "template_file" "tkg-cluster-template" {
    template = file("${path.module}/template/vsphere-tpl-workload.yaml")
    vars = {
        CLUSTER_NAME = var.cluster_name
        VSPHERE_SERVER = local.vpshere_env_server
        VSPHERE_USERNAME = local.vpshere_env_user
        VSPHERE_PASSWORD = local.vpshere_env_password

        VSPHERE_DATACENTER: join("",["/",local.tkg_env_datacenter])
        VSPHERE_RESOURCE_POOL:  join("/",["",local.tkg_env_datacenter,"host",local.tkg_env_cluster,"Resources",local.tkg_env_resource_pool])
        VSPHERE_DATASTORE: join("/",["",local.tkg_env_datacenter,"datastore",local.tkg_env_datastore])
        VSPHERE_FOLDER: join("/",["",local.tkg_env_datacenter,"vm",local.tkg_env_vm_folder])
        VSPHERE_NETWORK: local.tkg_env_network
        VSPHERE_CONTROL_PLANE_ENDPOINT: var.cluster_management_ip
        VSPHERE_SSH_AUTHORIZED_KEY: local.bootvm_rsa
        

    }
}

resource "sshclient_scp_put" "bootvm_tpl_clsuter" {
    host_json   = data.sshclient_host.bootvm_main.json
    data = data.template_file.tkg-cluster-template.rendered
    remote_path = "/root/tkglab/vsphere-tkg-clsuter-${var.cluster_name}-template.yaml"
    permissions = "664"
}

resource "null_resource" "create_cluster" {
    depends_on = [
        sshclient_scp_put.bootvm_tpl_clsuter
    ]

    provisioner "remote-exec" {
 		inline = [
 		    "tanzu cluster create -f /root/tkglab/vsphere-tkg-clsuter-${var.cluster_name}-template.yaml"
 		]
 		connection {
 		    host = local.bootvm_ip
 		    type     = "ssh"
 			user     = "root"
 			password = local.bootvm_password
 		}
 	}
}

data "sshcommand_command" "generate_kubectl" {
    depends_on = [
      null_resource.create_cluster
    ]
    host = local.bootvm_ip
    user = "root"
    password = local.bootvm_password
    command = "tanzu cluster kubeconfig get ${var.cluster_name} --admin --export-file /root/tkglab/kubeconfig-${var.cluster_name}"
}

data "sshcommand_command" "get_kubectl" {
    depends_on = [
      data.sshcommand_command.generate_kubectl
    ]
    host = local.bootvm_ip
    user = "root"
    password = local.bootvm_password
    command = "cat /root/tkglab/kubeconfig-${var.cluster_name}"
}

#retrive kubbeconfig
resource "local_file" "get_kubeconfig" {
    content      = data.sshcommand_command.get_kubectl.result
    filename = "${var.files_path}/${var.cluster_name}-kubeconfig"
}

# Add kubectl to vault
resource "vault_generic_secret" "vault_secret_cluster_kube" {
  path = "secret/cluster_${var.cluster_name}"
  data_json = <<EOT
{
  "kubeconf":   "${base64encode(data.sshcommand_command.get_kubectl.result)}"
}
EOT
}

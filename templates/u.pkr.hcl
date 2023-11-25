packer {
  required_plugins {
    qemu = {
      version = ">= 1.0.0"
      source = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "ubuntu" {
  accelerator = "kvm"
  boot_command = [
    "<esc><wait>",
    "install <wait>",
    "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ <wait>"
  ]
  boot_wait = "5s"
  disk_size = 8192
  http_directory = "http"
  iso_checksum = "sha256:a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
  iso_url = "http://releases.ubuntu.com/22.04/ubuntu-22.04.3-live-server-amd64.iso"
  ssh_username = "ubuntu"
  ssh_password = "ubuntu"
  ssh_timeout = "20m"
  format = "qcow2"
  vm_name = "aws-ubuntu.qcow2"
}

build {
  sources = ["source.qemu.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y awscli"
    ]
  }
}

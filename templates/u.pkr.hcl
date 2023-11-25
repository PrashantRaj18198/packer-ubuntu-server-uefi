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
  disk_size = 8192
  format = "qcow2"
  image_checksum = "sha256:f2c748fd426f4055a0c3a6d01f0282fa75aa89e514d165845fec117cb479d840"
  image_url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img"
  ssh_username = "packerubuntu"
  ssh_password = "packerubuntu"
  ssh_timeout = "20m"
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

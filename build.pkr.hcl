source "azure-arm" "build" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

build {
  name = "devbox"

  source "source.azure-arm.build" {
    location = var.location
    vm_size  = "Standard_D4_v5"

    os_type         = "Windows"
    image_publisher = "MicrosoftVisualStudio"
    image_offer     = "visualstudioplustools"
    image_sku       = "vs-2022-ent-general-win11-m365-gen2"

    managed_image_name                 = "${var.image_name_prefix}-${formatdate("YYYYMMDDhhmmss",timestamp())}"
    managed_image_resource_group_name  = var.resource_group_name

    communicator   = "winrm"
    winrm_use_ssl  = true
    winrm_insecure = true
    winrm_timeout  = "3m"
    winrm_username = "packer"
  }

  # Install the Chocolatey package manager
  provisioner "powershell" {
    inline = [
      "Set-ExecutionPolicy Bypass -Scope Process -Force;",
      "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    ]
  }

  # Install Terraform
  provisioner "powershell" {
    inline = [
      "choco install terraform -y"
    ]
  }
}

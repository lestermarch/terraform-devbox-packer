source "azure-arm" "devbox" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

build {
  name = "devbox"

  source "source.azure-arm.devbox" {
    managed_image_name                = var.resource_group_name
    managed_image_resource_group_name = "${var.image_name_prefix}-${formatdate("YYYYMMDDhhmmss",timestamp())}"

    os_type         = "Windows"
    image_publisher = "MicrosoftVisualStudio"
    image_offer     = "visualstudio2022"
    image_sku       = "vs-2022-ent-general-win11-m365-gen2"

    location = var.location
    vm_size  = "Standard_D2_v2"
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

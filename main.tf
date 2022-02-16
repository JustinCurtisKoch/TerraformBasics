data "azurerm_subnet" "subnet_data" {
  name                 = var.subnet1
  virtual_network_name = azurerm_virtual_network.demo_network.name
  resource_group_name  = azurerm_resource_group.ResGrptf.name
}

output "subnet_info" {
  value = data.azurerm_subnet.subnet_data.id
}

resource "azurerm_resource_group" "ResGrptf" {
  name     = var.jck_tf_RG
  location = var.location
}
resource "azurerm_network_security_group" "my_NSG" {
  name                = var.demo_network_NSG
  location            = azurerm_resource_group.ResGrptf.location
  resource_group_name = azurerm_resource_group.ResGrptf.name
}

resource "azurerm_virtual_network" "demo_network" {
  name                = var.network_name
  location            = azurerm_resource_group.ResGrptf.location
  resource_group_name = azurerm_resource_group.ResGrptf.name
  address_space       = var.address_space

  subnet {
    name           = var.subnet1
    address_prefix = var.subnet1_address
    security_group = azurerm_network_security_group.my_NSG.id
  }

  subnet {
    name           = var.subnet2
    address_prefix = var.subnet2_address
    security_group = azurerm_network_security_group.my_NSG.id
  }

  tags = var.tags
}

resource "azurerm_network_interface" "linux_nic" {
  name                = "demo-nic"
  location            = azurerm_resource_group.ResGrptf.location
  resource_group_name = azurerm_resource_group.ResGrptf.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet_data.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "linux1" {
  name                  = "${var.network_name}-${var.subnet1}-linux1"
  location              = azurerm_resource_group.ResGrptf.location
  resource_group_name   = azurerm_resource_group.ResGrptf.name
  network_interface_ids = [azurerm_network_interface.linux_nic.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "linux1osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "azureuser"
    admin_password = "1234!@#$qweQWE"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}
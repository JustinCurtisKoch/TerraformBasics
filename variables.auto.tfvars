# service principle credentials
subscription_id = ""
client_id       = ""
client_secret   = ""
tenant_id       = ""

#resource group variables
jck_tf_RG = "terraformbuild"
location  = "eastus"

#networking variables
demo_network_NSG = "my_NSG"
network_name     = "demo_network"
address_space    = ["10.0.0.0/16"]
subnet1          = "subnet1"
subnet1_address  = "10.0.1.0/24"
subnet2          = "subnet2"
subnet2_address  = "10.0.2.0/24"

tags = {
  "name" = "JCK"
}
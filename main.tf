#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*                 Root Module                         *#
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

# Remote Backend

terraform {
    backend "azurerm" {
        resource_group_name     =   "remote-state"
        storage_account_name    =   "terraformstate4"
        container_name          =   "tfremote"
        key                     =   "terraform.tfstate"
    }
}

# Provider Block

provider "azurerm" {
    version         =   ">= 2.26"
    client_id       =   var.client_id
    client_secret   =   var.client_secret
    subscription_id =   var.subscription_id
    tenant_id       =   var.tenant_id
    
    features {
        virtual_machine {
            delete_os_disk_on_deletion = true
        }
    }
}

provider "azuread" {
    version         =   ">= 0.11"
    client_id       =   var.client_id
    client_secret   =   var.client_secret
    subscription_id =   var.subscription_id
    tenant_id       =   var.tenant_id
    alias           =   "ad"
}

// module "winvm" {
//     source = "./azure/windowsVM"
// }

// module "customrole" {
//     source  =   "./azure/custom-roles"
// }

// module "provisioners" {
//     source  =   "./azure/provisioners-example"
// }

module "linuxvm" {
    source  =   "./azure/linuxVM"
}


#!/bin/bash

# Variables
rg="user-htzviwlbxqcx"
location="eastus"
vnetName="VNET"
subnetName="SUBNET_1"
vmName="IMAGE_VM"
vmName2="VIDEO_VM"
adminUsername="jm"
adminPassword="abcd1234"

# Check if resource group exists
if az group exists --name $rg
then
    echo "Resource group $rg already exists."
else
    # Create resource group
    az group create --name $rg --location $location
fi

# Create virtual network
az network vnet create --resource-group $rg --name $vnetName --address-prefixes 10.0.0.0/16

# Create subnet
az network vnet subnet create --resource-group $rg --vnet-name $vnetName --name $subnetName --address-prefixes 10.0.0.0/24

# Create VMs
az vm create --resource-group $rg --name $vmName --image Ubuntu2204 --vnet-name $vnetName --subnet $subnetName --admin-username $adminUsername --admin-password $adminPassword
az vm create --resource-group $rg --name $vmName2 --image Ubuntu2204 --vnet-name $vnetName --subnet $subnetName --admin-username $adminUsername --admin-password $adminPassword

# Set up web servers
for vm in $vmName $vmName2
do
    az vm extension set --resource-group $rg --vm-name $vm --name customScript --publisher Microsoft.Azure.Extensions --settings '{"script":"#!/bin/bash\napt-get update -y\napt-get upgrade -y\napt-get install apache2 -y\necho \"See all of your IMAGES here!\" > /var/www/html/images/index.html\necho \"See all of your VIDEOS here!\" > /var/www/html/videos/index.html\nmkdir /var/www/html/images\nmv /var/www/html/index.html /var/www/html/images/index.html\nmkdir /var/www/html/videos\nmv /var/www/html/index.html /var/www/html/videos/index.html"}' --no-wait
done

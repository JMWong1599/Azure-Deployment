# Install Azure CLI Linux Ubuntu - curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
#!/bin/bash

# Set your variables
rg="user-mkhwcnutdrfv"
location="eastus"
vmName="Control-plane"
vmName1="Worker-1"
vmName2="Worker-2"
vmName3="Rancher-server"
adminUsername="kube"
adminPassword="Tinged-456!69420"
vnetName="K8S-VNET"
subnetName="K8S-SUBNET_1"

# Create Virtual Network
az network vnet create \
    --resource-group $rg \
    --name $vnetName \
    --address-prefixes 10.0.0.0/16 \
    --location $location

# Create Subnet
az network vnet subnet create \
    --resource-group $rg \
    --vnet-name $vnetName \
    --name $subnetName \
    --address-prefixes 10.0.0.0/24

# Create Control-plane VM
az vm create \
    --resource-group $rg \
    --name $vmName \
    --image Ubuntu2204 \
    --admin-username $adminUsername \
    --admin-password $adminPassword \
    --location $location \
    --vnet-name $vnetName \
    --subnet $subnetName

# Create Worker-1 VM
az vm create \
    --resource-group $rg \
    --name $vmName1 \
    --image Ubuntu2204 \
    --admin-username $adminUsername \
    --admin-password $adminPassword \
    --location $location \
    --vnet-name $vnetName \
    --subnet $subnetName

# Create Worker-2 VM
az vm create \
    --resource-group $rg \
    --name $vmName2 \
    --image Ubuntu2204 \
    --admin-username $adminUsername \
    --admin-password $adminPassword \
    --location $location \
    --vnet-name $vnetName \
    --subnet $subnetName

# Create Rancher-server VM
az vm create \
    --resource-group $rg \
    --name $vmName3 \
    --image Ubuntu2204 \
    --admin-username $adminUsername \
    --admin-password $adminPassword \
    --location $location \
    --vnet-name $vnetName \
    --subnet $subnetName

echo "Script execution completed."

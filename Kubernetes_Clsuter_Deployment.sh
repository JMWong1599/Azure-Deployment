# Install Azure CLI Linux Ubuntu - curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
# Set your variables
rg="user-trhftmtatnny"
location="eastus"
vnetName="K8S-VNET"
subnetName="K8S-SUBNET_1"
vmName="Control-plane"
vmName1="Worker-1"
vmName2="Worker-2"
vmName3="Rancher-server"
adminUsername="kube"
adminPassword="Tinged-456!69420"

# Create a virtual network if it doesn't exist
az network vnet show --resource-group $rg --name $vnetName || \
  az network vnet create --resource-group $rg --name $vnetName --address-prefixes 10.0.0.0/16 --subnet-name $subnetName --subnet-prefix 10.0.0.0/24

# Create a control plane VM
az vm create \
  --resource-group $rg \
  --name $vmName \
  --image Ubuntu2204 \
  --admin-username $adminUsername \
  --admin-password $adminPassword \
  --vnet-name $vnetName \
  --subnet $subnetName \
  --public-ip-address ""

# Create Worker-1 VM
az vm create \
  --resource-group $rg \
  --name $vmName1 \
  --image Ubuntu2204 \
  --admin-username $adminUsername \
  --admin-password $adminPassword \
  --vnet-name $vnetName \
  --subnet $subnetName \
  --public-ip-address ""

# Create Worker-2 VM
az vm create \
  --resource-group $rg \
  --name $vmName2 \
  --image Ubuntu2204 \
  --admin-username $adminUsername \
  --admin-password $adminPassword \
  --vnet-name $vnetName \
  --subnet $subnetName \
  --public-ip-address ""

# Create Rancher-server VM
az vm create \
  --resource-group $rg \
  --name $vmName3 \
  --image Ubuntu2204 \
  --admin-username $adminUsername \
  --admin-password $adminPassword \
  --vnet-name $vnetName \
  --subnet $subnetName \
  --public-ip-address ""

echo "Script execution completed."

#!/bin/bash

# Use with docker: https://docs.microsoft.com/en-us/cli/azure/run-azure-cli-docker :
#   # powershell
#   if((Test-Path "${HOME}/.ssh") -eq $False) { New-Item -Path ${HOME} -Name ".ssh" }
#   if((Test-Path "${HOME}/.kube") -eq $False) { New-Item -Path ${HOME} -Name ".kube" }
#   docker pull mcr.microsoft.com/azure-powershell:latest
#   docker run -it --rm -v ${HOME}/.ssh:/root/.ssh -v ${HOME}/.kube:/root/.kube mcr.microsoft.com/azure-powershell:latest

#   # bash
#   docker pull mcr.microsoft.com/azure-cli:latest
#   mkdir -p ${HOME}/.ssh && mkdir -p ${HOME}/.kube
#   docker run -it --rm -v ${HOME}/.ssh:/root/.ssh -v ${HOME}/.kube:/root/.kube mcr.microsoft.com/azure-cli:latest

# login into Azure (one time only). Inside a docker container, you will need to open https://aka.ms/devicelogin to continue the login
az login

## -------------- ##

# Create k8s cluster
#   (inside the docker container, must remove the leading $ in the variable declaration)
resourceGroup='k8sPresentationResource'
k8sClusterName='k8sPresentationCluster'
location='brazilsouth'
k8sVersion='1.20.7'  # list supported kubernetes version: az aks get-versions --location $location --output table
vmSize='Standard_B2s'

az configure --defaults location=$location

# First create a resource group
az group create --name $resourceGroup --location $location

# AKS cluster and cluster autoscaler
az aks create \
  --resource-group $resourceGroup \
  --name $k8sClusterName \
  --kubernetes-version $k8sVersion \
  --node-count 2 \
  --vm-set-type VirtualMachineScaleSets \
  --load-balancer-sku standard \
  --enable-cluster-autoscaler \
  --node-vm-size $vmSize \
  --min-count 2 --max-count 3 \
  --enable-addons http_application_routing
# --attach-acr <acrName> # if using Azure Arc
# only if .ssh is mapped into the container
#  --generate-ssh-keys

# install kubectl
az aks install-cli

# configure ~/.kube/config
az aks get-credentials --resource-group $resourceGroup --name $k8sClusterName

# enabling additional addons
az aks enable-addons --addons monitoring --resource-group $resourceGroup --name $k8sClusterName

# show cluster stats
az aks show --resource-group $resourceGroup --name $k8sClusterName 

# show cluster Url
az aks show --resource-group $resourceGroup --name $k8sClusterName --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName -o table

# Stop the Cluster ( https://docs.microsoft.com/en-us/azure/aks/start-stop-cluster )
#   => Stop all nodes, including the controllers, to save costs
az aks stop --name $k8sClusterName --resource-group $resourceGroup

# Start a previous stopped cluster
az aks start --name $k8sClusterName --resource-group $resourceGroup

# Delete the Cluster ( https://docs.microsoft.com/en-us/azure/aks/start-stop-cluster )
#  => cannot be restored
az aks delete --name $k8sClusterName --resource-group $resourceGroup --yes

# Delete the Resource Group
az group delete --name $resourceGroup

#!/bin/bash
LOCATION="australiaeast"
RESOURCE_GROUP_NAME="Aks-rg"
APP_GATEWAY_NAME="webApplicationGateway"
NODE_VN_SIZE="Standard_B2s"
AKS_CLUSTER_NAME="webAksCluster"
ACR_NAME="webappacr12356"
#Create Resource Group
az group create -n $RESOURCE_GROUP_NAME -l $LOCATION &&

#Create Aks CLuster
  az aks create -n $AKS_CLUSTER_NAME -g $RESOURCE_GROUP_NAME --network-plugin azure --enable-managed-identity -a ingress-appgw --appgw-name $APP_GATEWAY_NAME --appgw-subnet-cidr "10.225.0.0/16" --generate-ssh-keys --node-vm-size $NODE_VN_SIZE  -l $LOCATION --enable-cluster-autoscaler  --max-count 2 --min-count 1 --node-count 1 &&
#Create acr
 az acr create --resource-group $RESOURCE_GROUP_NAME --name $ACR_NAME --sku Basic &&

 #Attach ACR to Aks
   az aks update -n $AKS_CLUSTER_NAME  -g $RESOURCE_GROUP_NAME --attach-acr $ACR_NAME

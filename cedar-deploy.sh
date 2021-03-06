#!/bin/bash

# create a service principal for this App before executing this script using command:  
# az ad sp create-for-rbac --skip-assignment --name cedarServicePrincipal

RESOURCE_GROUP="cedar-rg"
AKS_CLUSTER_NAME="cedar-ks"
EVENTHUB_NAMESPACE="cedarhub"
EVENTHUB_NAME="locationhub"
LOCATION="uswest"
EVENTHUB_LOCATION="westus"

# Parameter 'ACR_NAME' must conform to the following pattern: '^[a-zA-Z0-9]*$'.
ACR_NAME="cedarcr"

SERVICE_PRINCIPAL="" #DO NOT COMMIT THIS

SECRET="" #DO NOT COMMIT THIS

if [ $(az group exists --name $RESOURCE_GROUP) = false ]; then
    az group create --name $RESOURCE_GROUP --location $LOCATION
fi

az aks create \
--resource-group $RESOURCE_GROUP \
--name $AKS_CLUSTER_NAME \
--service-principal  $SERVICE_PRINCIPAL \
--client-secret  $SECRET \
--generate-ssh-keys

# Get the id of the service principal configured for AKS
CLIENT_ID=$(az aks show --resource-group "$RESOURCE_GROUP" --name "$AKS_CLUSTER_NAME" --query "servicePrincipalProfile.clientId" --output tsv)

# create container registry
az acr create --resource-group $RESOURCE_GROUP --name $ACR_NAME --sku Basic

# Get the ACR registry resource id
ACR_ID=$(az acr show --name "$ACR_NAME" --resource-group "$ACR_RESOURCE_GROUP" --query "id" --output tsv)

# Create role assignment
az role assignment create --assignee $CLIENT_ID --role acrpull --scope $ACR_ID

az eventhubs namespace create --name $EVENTHUB_NAMESPACE --resource-group $RESOURCE_GROUP -l $EVENTHUB_LOCATION
# Create an event hub. Specify a name for the event hub. 
az eventhubs eventhub create --name $EVENTHUB_NAME --resource-group $RESOURCE_GROUP --namespace-name $EVENTHUB_NAMESPACE
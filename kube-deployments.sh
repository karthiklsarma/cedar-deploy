#!/bin/bash

# If running this for the first time
# sudo az aks install-cli
# kubelogin

az aks get-credentials --resource-group cedar-rg --name cedar-ks
kubectl apply -f ./deployments/cedar-engine.yaml
kubectl apply -f ./services/cedar-engine.yaml
#!/bin/bash

# If running this for the first time
# sudo az aks install-cli
# kubelogin

az aks get-credentials --resource-group cedar-rg --name cedar-ks
# If config already exists or if you are running this script the second time, you can choose to keep the config
#A different object named cedar-ks already exists in your kubeconfig file.
#Overwrite? (y/n): n
#A different object named clusterUser_cedar-rg_cedar-ks already exists in your kubeconfig file.
#Overwrite? (y/n): n

kubectl apply -f ./secrets/cedar-stream.yaml
kubectl apply -f ./secrets/cedar-map.yaml
kubectl apply -f ./deployments/cedar-server.yaml
kubectl apply -f ./deployments/cedar-listener.yaml
kubectl apply -f ./services/cedar-server.yaml

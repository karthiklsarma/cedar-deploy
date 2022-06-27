#!/bin/bash
resource_group=$1
cosmos_account='cedarcosmosaccount'
cosmos_keyspace='cedarcosmoskeyspace'
location_table='cedarlocation'
user_table='cedarusers'
location_schema='@location-schema.json'
user_schema='@user-schema.json'

if [ -z "$resource_group" ]
then
    echo "Please provide a resource group name"
fi

az cosmosdb create \
-n $cosmos_account \
-g $resource_group \
--default-consistency-level Eventual \
--capabilities EnableCassandra \
--locations regionName='West US 2' failoverPriority=0 isZoneRedundant=False

az cosmosdb cassandra keyspace create \
-a $cosmos_account \
-g $resource_group \
-n $cosmos_keyspace

az cosmosdb cassandra table create \
-a $cosmos_account \
-g $resource_group \
-k $cosmos_keyspace \
-n $location_table \
--throughput 400 \
--schema $location_schema

az cosmosdb cassandra table create \
-a $cosmos_account \
-g $resource_group \
-k $cosmos_keyspace \
-n $user_table \
--throughput 400 \
--schema $user_schema
#!/bin/sh

helm repo add datadog https://helm.datadoghq.com
helm repo update

source ./config

kubectl create namespace $NAMESPACE

helm upgrade --install datadog \
  --set datadog.clusterName=$CLUSTER_NAME \
  --set datadog.tags=["env:$ENV"] \
  datadog/datadog --namespace $NAMESPACE -f values.yaml

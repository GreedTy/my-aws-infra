#!/bin/sh

source ./config

for ITEM in $NLB_COMPONENTS; do
  helm uninstall ingress-nginx-$ITEM --namespace $NAMESPACE
done

kubectl delete namespace $NAMESPACE

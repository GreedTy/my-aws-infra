#!/bin/sh

source ./config

for ITEM in $NAMESPACES; do
  kubectl delete namespace $ITEM
done

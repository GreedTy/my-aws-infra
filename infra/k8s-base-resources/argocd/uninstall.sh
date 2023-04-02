#!/bin/sh

source ./config

helm uninstall argocd --namespace $NAMESPACE

kubectl delete namespace $NAMESPACE

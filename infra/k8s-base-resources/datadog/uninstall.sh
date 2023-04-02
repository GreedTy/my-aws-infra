#!/bin/sh

source ./config

helm uninstall datadog --namespace $NAMESPACE

kubectl dalete namespace $NAMESPACE

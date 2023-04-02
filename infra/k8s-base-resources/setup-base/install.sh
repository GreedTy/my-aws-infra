#!/bin/sh

source ./config

for ITEM in $NAMESPACES; do
  kubectl create namespace $ITEM

  kubectl create -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  namespace: $ITEM
  name: secret
EOF

done

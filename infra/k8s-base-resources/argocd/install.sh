#!/bin/sh

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

source ./config

kubectl create namespace $NAMESPACE

helm upgrade --install argocd -n $NAMESPACE argo/argo-cd -f - <<EOF
server:
  config:
    # solution for ingress state 'Progressing'
    # https://github.com/argoproj/argo-cd/issues/1704
    resource.customizations: |
      networking.k8s.io/Ingress:
        health.lua: |
          hs = {}
          hs.status = "Healthy"
          return hs
  extraArgs:
    - --insecure
    - --rootpath=$INGRESS_PATH
  ingress:
    enabled: true
#    annotations:
#       nginx.ingress.kubernetes.io/whitelist-source-range: 49.36.X.X/32
    ingressClassName: $INGRESS_CLASS_NAME
    paths:
      - $INGRESS_PATH
    https: true
EOF

#echo "Enter your initial admin password(encrypted with bcrypt):"
#read PASSWORD
#
#kubectl -n argocd patch secret argocd-secret \
#  -p '{"stringData": {
#    "admin.password": "$PASSWORD",
#    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
#  }}'

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

kubectl get svc -n argocd

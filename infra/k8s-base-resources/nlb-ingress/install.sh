#!/bin/sh

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

source ./config

kubectl create namespace $NAMESPACE

SUBNET_COUNT=`aws ec2 describe-subnets --filters "Name=tag:Name,Values=$NLB_SUBNET_FILTER" | jq -r '[.Subnets[].SubnetId] | length'`

# You have to apply the configmap.yaml before creating the ingress controller.
for ITEM in $NLB_COMPONENTS; do
  helm upgrade --install ingress-nginx-$ITEM ingress-nginx/ingress-nginx --set controller.customTemplate.configMapKey="nginx.tmpl" --set controller.customTemplate.configMapName="nginx-template" \
    --namespace $NAMESPACE -f - <<EOF
controller:
  replicaCount: $SUBNET_COUNT
  ingressClassResource:
    name: nginx-$ITEM  # default: nginx
    enabled: true
#    default: false
    controllerValue: "k8s.io/$ITEM-ingress-nginx"  # default: k8s.io/ingress-nginx
  ingressClassByName: true
  service:
    annotations:
      service.beta.kubernetes.io/aws-load-balancer-name: lb-$ENV-$ITEM
      service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: ip
      service.beta.kubernetes.io/aws-load-balancer-scheme: internet-facing
      service.beta.kubernetes.io/aws-load-balancer-type: external
      service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled: true
EOF
done

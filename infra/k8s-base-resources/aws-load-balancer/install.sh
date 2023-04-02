#!/bin/sh

helm repo add eks https://aws.github.io/eks-charts
helm repo update

source ./config

curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.0/docs/install/iam_policy.json

aws iam create-policy \
    --policy-name $POLICY_NAME \
    --policy-document file://iam-policy.json

POLICY_ARN=arn:aws:iam::$AWS_ACCOUNT_ID:policy/$POLICY_NAME

eksctl create iamserviceaccount \
  --cluster=$CLUSTER_NAME \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=$POLICY_ARN \
  --override-existing-serviceaccounts \
  --region $AWS_REGION \
  --approve

helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system \
  --set clusterName=$CLUSTER_NAME \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller

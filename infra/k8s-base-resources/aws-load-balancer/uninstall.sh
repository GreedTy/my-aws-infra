#!/bin/sh

source ./config

helm uninstall aws-load-balancer-controller --namespace kube-system

eksctl delete iamserviceaccount \
  --cluster=$CLUSTER_NAME \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --region $AWS_REGION

POLICY_ARN=arn:aws:iam::$AWS_ACCOUNT_ID:policy/$POLICY_NAME

aws iam get-policy --policy-arn $POLICY_ARN

#ROLE_NAME=$(aws iam list-entities-for-policy --policy-arn $POLICY_ARN | jq -r '.PolicyRoles[0].RoleName')
#
#aws iam detach-role-policy --role-name $ROLE_NAME \
#  --policy-arn $POLICY_ARN

aws iam delete-policy \
  --policy-arn $POLICY_ARN

#!/bin/bash

AWS_ACCOUNT_ID="765288911542"
AWS_REGION="us-east-1"
NAMESPACE="production"

echo "Getting ECR login token..."
ECR_PASSWORD=$(aws ecr get-login-password --region $AWS_REGION)

echo "Creating ecr-pull-secret in namespace: $NAMESPACE..."
kubectl create secret docker-registry ecr-pull-secret \
  --namespace=$NAMESPACE \
  --docker-server="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com" \
  --docker-username=AWS \
  --docker-password="${ECR_PASSWORD}" \
  --dry-run=client -o yaml | kubectl apply -f -

echo "Done! Secret created."
#!/bin/bash

eksctl create cluster
kubectl apply -f ./tiller_service_account.yaml
helm init --service-account tiller

Echo "Update aws-auth configmap if you wish to provide additional access to your cluster."
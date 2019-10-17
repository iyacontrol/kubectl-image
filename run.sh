#!/bin/sh

set -o errexit
set -o pipefail

VENDOR=/var/run/secrets/kubernetes.io/serviceaccount
BEARER_TOKEN=$(cat $VENDOR/token)

kubectl config --kubeconfig=$KUBECONFIG \
    set-cluster \
    $CLUSTER \
    --server=$APISERVER \
    --certificate-authority=$VENDOR/ca.crt

kubectl config --kubeconfig=$KUBECONFIG \
    set-credentials scmp --token=$BEARER_TOKEN

kubectl config --kubeconfig=$KUBECONFIG \
    set-context scmp-context \
    --cluster=$CLUSTER \
    --user=scmp

kubectl config --kubeconfig=$KUBECONFIG \
    use-context scmp-context

while : ; do 
  sleep 3600
done
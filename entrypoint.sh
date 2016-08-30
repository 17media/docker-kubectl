#!/usr/bin/env sh
set -e

if [ ! -z "$KUBE_CONTEXT" ]; then
    if [ ! -z "$KUBE_CLUSTER_TOKEN" ]; then
        kubectl config set-credentials $KUBE_CONTEXT --token $KUBE_CLUSTER_TOKEN
    fi

    if [ ! -z "$KUBE_CLUSTER_ENDPOINT" ]; then
        if [ ! -z "$KUBE_CLUSTER_CA" ]; then
            echo $KUBE_CLUSTER_CA | base64 -d > ca.crt && \
            kubectl config set-cluster $KUBE_CONTEXT --certificate-authority ca.crt --embed-certs --server $KUBE_CLUSTER_ENDPOINT && \
            rm ca.crt
        else
            kubectl config set-cluster $KUBE_CONTEXT --server $KUBE_CLUSTER_ENDPOINT
        fi
    fi

    kubectl config set-context $KUBE_CONTEXT --cluster $KUBE_CONTEXT --user $KUBE_CONTEXT && \
    kubectl config use-context $KUBE_CONTEXT
fi

exec "$@"

#!/usr/bin/env bash

echo "[$(date)]        INFO:[+]Deploying spark-standalone onto kubernetes cluster    [started]"

echo "[$(date)]        INFO:[+]Creating namespace for spark         [started]" && cd kubernetes && kubectl create ns spark-cluster &&
    echo "[$(date)]        INFO:[+]Creating namespace for spark         [success]"

echo "[$(date)]        INFO:[+]Spark master and worker deployment         [started]" && kubectl create -f spark-on-kubernetes.yaml  && sleep 10 &&
    echo "[$(date)]        INFO:[+]Spark master and worker deployment         [success]"

kubectl get all -n spark-cluster

echo "[$(date)]        INFO:[+]Deploying spark onto kubernetes cluster    [success]"
#!/usr/bin/env bash

echo "[$(date)]        INFO:[+]Deploying spark onto kubernetes cluster    [started]"

echo "[$(date)]        INFO:[+]Create Docker image for spark        [started]" && cd docker  && docker build -t spark-hadoop  . && cd - &&
 echo "[$(date)]        INFO:[+]Create Docker image for spark       [done]"

echo "[$(date)]        INFO:[+]Create a namespace for spark-cluster     [started]" && kubectl create ns spark-cluster &&
 echo "[$(date)]        INFO:[+]Creating namespace spark-cluster     [done]"

echo "[$(date)]        INFO:[+]Create spark-cluster on kubernetes     [started]" && kubectl create -f kubernetes/spark-on-kubernetes.yaml -n spark-cluster &&
 echo "[$(date)]        INFO:[+]Deploying spark onto kubernetes cluster    [done]"

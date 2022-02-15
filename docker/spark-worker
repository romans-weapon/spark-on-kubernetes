#!/bin/bash

. /common.sh

if ! getent hosts spark-master; then
  sleep 5
  exit 0
fi


# Run spark-class directly so that when it exits (or crashes), the pod restarts.
/opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://spark-master.sh:7077 --webui-port 8081

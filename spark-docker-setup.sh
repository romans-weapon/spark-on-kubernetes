#!/usr/bin/env bash

echo "[$(date)]        INFO:[+]Deploying spark onto docker env                       [started]"

echo "[$(date)]        INFO:[+]Starting containers for spark master and workers        [started]" && cd docker-compose && docker-compose up -d && sleep 10 &&
    echo "[$(date)]        INFO:[+]Starting containers for spark master and workers        [success]"

echo "[$(date)]        INFO:[+]Deploying spark onto docker env                       [success]"
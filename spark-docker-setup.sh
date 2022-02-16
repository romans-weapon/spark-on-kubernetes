#!/usr/bin/env bash

echo "[$(date)]        INFO:[+]Deploying spark onto docker env    [started]"

echo "[$(date)]        INFO:[+]Starting containers for spark master and worker        [started]" && cd docker-compose && docker-compose up -d && sleep 10 &&
    echo "[$(date)]        INFO:[+]Starting containers for spark master and worker        [ok]"

echo "[$(date)]        INFO:[+]Deploying spark onto docker env    [ok]"
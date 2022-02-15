#!/bin/bash

# We don't want any of the incoming service variables, we'd rather use
# DNS. But this one interferes directly with Spark.
# unset variable set by kubernetes
unset SPARK_MASTER_PORT

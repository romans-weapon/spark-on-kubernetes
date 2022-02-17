# Spark-on-kubernetes

[![Code Quality Grade](https://api.codiga.io/project/31364/score/svg)](https://api.codiga.io/project/31364/score/svg)
[![Code Quality Score](https://api.codiga.io/project/31364/status/svg)](https://api.codiga.io/project/31364/status/svg)

A faster way to setup spark-standalone on a docker environment or any kubernetes cluster.

# Table of contents

- [Pre-requisites](#pre-requisites)
- [Versions Support](#versions-support)
- [Installation steps](#installation-steps)
    - [Docker Environment](#docker-environment)
        - [Steps to run spark using docker-compose](#steps-to-run-spark-using-docker-compose)
        - [How to use it](#how-to-use-it)
    - [Kubernetes Environment](#kubernetes-environment)
        - [Steps to run spark on any kubernetes cluster](#steps-to-run-spark-on-any-kubernetes-cluster)
        - [How to use it](#how-to-use-it)
    - [Web-ui](#web-ui)
    
## Pre-requisites

For running spark-standalone you simply place a compiled version of Spark on each node on the cluster.The installation steps were taken from the [official documentation](https://spark.apache.org/docs/latest/spark-standalone.html#spark-standalone-mode)
and containerized for running it on a docker environment or Kubernetes environment.
To install spark on any of these environments we need to have:
1. Docker and docker-compose installed on your machine.
2. Kubernetes cluster installed on your machine if you want to install spark on kubernetes.

## Versions Support

| Service      | Version     |
| -----------  | ----------- |
| Spark        | 3.2.0       |
| Hadoop       | 3.1.1       |

# Installation steps

## Docker Environment
### Steps to run spark using docker-compose
1. Clone the project abd navigate to the main directory
```commandline
git clone -b spark-3.2 https://github.com/romans-weapon/spark-on-kubernetes.git && cd spark-on-kubernetes/
```

2. Run the script file to setup spark using docker-compose with the below command
```commandline
sh spark-docker-setup.sh
```

##### Output:

```commandline
kmaster@ubuntu:~/spark-on-kubernetes$ sh spark-docker-setup.sh
[Wed Feb 16 02:36:38 AM PST 2022]        INFO:[+]Deploying spark onto docker env                        [started]
[Wed Feb 16 02:36:38 AM PST 2022]        INFO:[+]Starting containers for spark master and worker        [started]
Creating network "docker-compose_default" with the default driver
Creating spark-master ... done
Creating spark-worker_2 ... done
Creating spark-worker_1 ... done
[Wed Feb 16 02:36:52 AM PST 2022]        INFO:[+]Starting containers for spark master and worker        [success]
[Wed Feb 16 02:36:52 AM PST 2022]        INFO:[+]Deploying spark onto docker env                        [success]
```

### How to use it

1. Once spark deployment is successful as shown above,check whether your containers are up and running as shown below

```commandline
kmaster@ubuntu:~/spark-on-kubernetes$ docker ps
CONTAINER ID   IMAGE                                 COMMAND                  CREATED          STATUS          PORTS                                                                                  NAMES
6d385f3290a7   spearframework/spark-3.2:kubernetes   "/bin/sh /spark-work…"   24 seconds ago   Up 22 seconds   0.0.0.0:8081->8081/tcp, :::8081->8081/tcp                                              spark-worker_1
60a16c12e1d9   spearframework/spark-3.2:kubernetes   "/bin/sh /spark-work…"   24 seconds ago   Up 22 seconds   0.0.0.0:8082->8082/tcp, :::8082->8082/tcp                                              spark-worker_2
3faca27d35bc   spearframework/spark-3.2:kubernetes   "/bin/sh /spark-mast…"   25 seconds ago   Up 23 seconds   0.0.0.0:7077->7077/tcp, :::7077->7077/tcp, 0.0.0.0:8080->8080/tcp, :::8080->8080/tcp   spark-master
```

2. Once they are healthy and running, you can exec into any of the worker nodes and start running spark as shown below

```commandline
kmaster@ubuntu:~/spark-on-kubernetes$ docker exec -it spark-worker_1 bash
root@6d385f3290a7:/# spark-shell
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
Spark context Web UI available at http://10.111.14.20:4040
Spark context available as 'sc' (master = spark://spark-master:7077, app id = app-20220217094729-0000).
Spark session available as 'spark'.
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 3.2.0
      /_/

Using Scala version 2.12.15 (OpenJDK 64-Bit Server VM, Java 1.8.0_111)
Type in expressions to have them evaluated.
Type :help for more information.

scala>
```

## Kubernetes Environment
### Steps to run spark on any kubernetes cluster

```commandline
git clone -b spark-3.2 https://github.com/romans-weapon/spark-on-kubernetes.git && cd spark-on-kubernetes/
```

2. Run the script file
```commandline
sh spark-kubernetes-setup.sh
```
##### Output:
Below is what you see when you run the script mentioned above

```commandline
kmaster@ubuntu:~/spark-on-kubernetes$ sh spark-kubernetes-setup.sh
[Thu Feb 17 01:46:01 AM PST 2022]        INFO:[+]Deploying spark-standalone onto kubernetes cluster    [started]
[Thu Feb 17 01:46:01 AM PST 2022]        INFO:[+]Creating namespace for spark         [started]
namespace/spark-cluster created
[Thu Feb 17 01:46:01 AM PST 2022]        INFO:[+]Creating namespace for spark         [success]
[Thu Feb 17 01:46:01 AM PST 2022]        INFO:[+]Spark master and worker deployment         [started]
deployment.apps/spark-master-deploy created
service/spark-master created
service/spark-webui created
deployment.apps/spark-worker-deploy created
[Thu Feb 17 01:46:12 AM PST 2022]        INFO:[+]Spark master and worker deployment         [success]
NAME                                       READY   STATUS    RESTARTS   AGE
pod/spark-master-deploy-7f8db7cd79-25dxt   1/1     Running   0          45s
pod/spark-worker-deploy-6dcf87f4fc-4v46c   1/1     Running   0          45s
pod/spark-worker-deploy-6dcf87f4fc-9wb5h   1/1     Running   0          45s
pod/spark-worker-deploy-6dcf87f4fc-cmlk2   1/1     Running   0          45s

NAME                   TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/spark-master   ClusterIP   10.245.253.203   <none>        7077/TCP   45s
service/spark-webui    ClusterIP   10.245.248.28    <none>        8080/TCP   45s

NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/spark-master-deploy   1/1     1            1           45s
deployment.apps/spark-worker-deploy   3/3     3            3           45s

NAME                                             DESIRED   CURRENT   READY   AGE
replicaset.apps/spark-master-deploy-7f8db7cd79   1         1         1       45s
replicaset.apps/spark-worker-deploy-6dcf87f4fc   3         3         3       45s
```

### How to use it

Once the above deployment is successful you can exec into any of the worker nodes and run your spark jobs as shown below

```commandline
kmaster@ubuntu:~/spark-on-kubernetes$ k exec -it spark-worker-deploy-6dcf87f4fc-cmlk2 -n spark-cluster -- bash
root@spark-worker-deploy-6dcf87f4fc-cmlk2:/# spark-shell
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
Spark context Web UI available at http://spark-worker-deploy-6dcf87f4fc-cmlk2:4040
Spark context available as 'sc' (master = spark://spark-master:7077, app id = app-20220217094729-0000).
Spark session available as 'spark'.
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 3.2.0
      /_/

Using Scala version 2.12.15 (OpenJDK 64-Bit Server VM, Java 1.8.0_111)
Type in expressions to have them evaluated.
Type :help for more information.

scala>
```

## Web-ui

Once you are able to submit your spark jobs you can view then on your webui at
``http://<host_name>:8080``

![img.png](images/img.png)


    
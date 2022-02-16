# spark-on-kubernetes
A faster spark setup on  any kubernetes cluster.


# Versions support

| Service      | Version     |
| -----------  | ----------- |
| Spark        | 2.4.7       |
| Hadoop       | 2.10.1      |

# Steps to setup

## Run spark on docker containers using docker-compose
1. Clone the project abd navigate to the main directory
```commandline
git clone -b spark-2.4 https://github.com/romans-weapon/spark-on-kubernetes.git && cd spark-on-kubernetes/
```

2. Run the script file
```commandline
sh spark-docker-setup.sh
```

### How to use it


## Run spark on any kubernetes cluster 

```commandline
git clone -b spark-2.4 https://github.com/romans-weapon/spark-on-kubernetes.git && cd spark-on-kubernetes/
```

2. Run the script file
```commandline
sh spark-kubernetes-setup.sh
```

### How to use it


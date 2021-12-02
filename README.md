# Improved scripts to quickly create,start/stop,destroy a 3-node kubeadm cluster 

Created cluster will have:

- 1 masternode, 2 workernodes (changeable in Vagrantfile), in virtualbox-VMs created with vagrant
- Pod-cidr: 10.244.0.0/16
- Weave CNI installed


## Requirements

A HOST (ex: laptop running ubuntu 18.04), with 6GB RAM, 6 CPUs, 30GB-disk, with following sw already installed:

- [Virtualbox](https://www.virtualbox.org)
- [vagrant](https://www.vagrantup.com/)


## Create cluster
```
## In HOST
./0.HOST.vagrant_up.sh


## In HOST
./ssh_kubemaster.sh
## Inside kubemaster
cat ~/kubeadm_join_command_for_additional_nodes.txt
## copy this
exit 


## In HOST
./ssh_kubenode01.sh
## Inside kubenode01
sudo su
## paste the copied command "kube join ..."
exit 
exit


## In HOST
./ssh_kubenode02.sh
## Inside kubenode02
sudo su
## paste the same copied command "kube join ..."
exit 
exit


## In HOST
source 3.HOST.kubeconfig.source
## At this point the cluster is up-and-running, and from the HOST we can execute kubectl (alias k) on the cluster:
k get nodes -o wide
atk get pod -A
#... play with the cluster...
```


## Ssh into kubemaster kubenode01 kubenode02

The same for any of the nodes:

- `./ssh_kubemaster.sh`
- `./ssh_kubenode01.sh`
- `./ssh_kubenode02.sh`

```
# In HOST
./ssh_kubemaster.sh
# Inside node
sudo su
```


## Stop/Start cluster 
```
# Stop cluster (ex: before shutting down HOST)
./8a.HOST.vagrant_halt.sh
```

```
# Start cluster
./8b.HOST.vagrant_up.sh
source 3.HOST.kubeconfig.source
## At this point the cluster is up-and-running, and from the HOST we can execute kubectl (alias k) on the cluster:
k get nodes -o wide
k get pod -A
#... play with the cluster...
```




## Destroy the cluster and VMs
```
./9.HOST.vagrant_destroy.sh
```




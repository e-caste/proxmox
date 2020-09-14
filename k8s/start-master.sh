#!/bin/bash
sudo kubeadm init --upload-certs --pod-network-cidr=192.168.0.0/16
# flannel --pod-network-cidr=10.244.0.0/16
read
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
read
# flannel
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# calico
kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml

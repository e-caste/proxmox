#!/bin/bash

# from https://pve.proxmox.com/wiki/Cloud-Init_Support
# to run from pve's root shell

# exit at first error
set -e

# see http://cloud-images.ubuntu.com
# e.g. bionic, focal
UBUNTU_VER=
# where to download the cloud image
# e.g. /mnt/pve/freenas/tmp, .
DL_PATH=
# the template VM number ID
# e.g. 9000
VM_NUM=
# the number of cores of the template VM
# e.g. 1, 2, 4, 64
VCPUS=
# the Mebibytes of memory of the template VM
# e.g. 512, 1024, 2048, 8192
MEM_MIB=
# the disk size of the template VM
# e.g. 16G, 64G
DISK_SIZE=
# the destination storage ID, where the disk will be stored
# it is the string in the left panel of the web dashboard
# e.g. local-lvm, local, freenas
DST_STORAGE_ID=
# the default username of the template VM
# e.g. ubuntu, johnny
USERNAME=
# the path to your id_rsa_X.pub files, one per line
# e.g. /root/id_rsa_proxmox.pub
SSHKEYS_PATH=

# download cloud image (only if it's newer than the already downloaded one)
wget https://cloud-images.ubuntu.com/$UBUNTU_VER/current/$UBUNTU_VER-server-cloudimg-amd64.img --directory-prefix=$DL_PATH --timestamping

# create default VM
qm create $VM_NUM --cores $VCPUS --memory $MEM_MIB --net0 virtio,bridge=vmbr0
qm importdisk $VM_NUM $DL_PATH/$UBUNTU_VER-server-cloudimg-amd64.img $DST_STORAGE_ID
qm set $VM_NUM --scsihw virtio-scsi-pci --scsi0 $DST_STORAGE_ID:$VM_NUM/vm-$VM_NUM-disk-0.raw
# add CDROM to pass cloud-init data
qm set $VM_NUM --ide2 $DST_STORAGE_ID:cloudinit
qm set $VM_NUM --boot c --bootdisk scsi0
qm set $VM_NUM --serial0 socket --vga serial0

# set cloudinit options
qm set $VM_NUM --ciuser $USERNAME \
        --ipconfig0 "ip=dhcp" \
        --sshkeys $SSHKEYS_PATH

# create template from this VM
qm resize $VM_NUM scsi0 $DISK_SIZE
qm set $VM_NUM --name ubuntu-server-$UBUNTU_VER
qm template $VM_NUM

# deploy with
# qm clone $VM_NUM $NEW_VM_NUM --name $NAME

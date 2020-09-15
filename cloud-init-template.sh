#!/bin/bash

# from https://pve.proxmox.com/wiki/Cloud-Init_Support
# to run from pve's root shell

# exit at first error
set -e

# set all needed vars in ci-vars.sh
source ci-vars.sh

# download cloud image (only if it's newer than the already downloaded one)
wget https://cloud-images.ubuntu.com/$UBUNTU_VER/current/$UBUNTU_VER-server-cloudimg-amd64.img --directory-prefix=$DL_PATH --timestamping

# create default VM
qm create $VM_NUM --cores $VCPUS --memory $MEM_MIB --net0 virtio,bridge=vmbr0
qm importdisk $VM_NUM $DL_PATH/$UBUNTU_VER-server-cloudimg-amd64.img $DST_STORAGE_ID
qm set $VM_NUM --scsihw virtio-scsi-pci --scsi0 $DST_STORAGE_ID:$VM_NUM/vm-$VM_NUM-disk-0.raw
qm set $VM_NUM --agent enabled=1
# add CDROM to pass cloud-init data
qm set $VM_NUM --ide2 $DST_STORAGE_ID:cloudinit
qm set $VM_NUM --boot c --bootdisk scsi0
qm set $VM_NUM --serial0 socket --vga serial0

# set cloudinit options
qm set $VM_NUM  --ipconfig0 "ip=dhcp" \
        --cicustom "user=$CI_YAML_PATH"

# create template from this VM
qm cloudinit dump $VM_NUM user
qm resize $VM_NUM scsi0 $DISK_SIZE
qm set $VM_NUM --name ubuntu-server-$UBUNTU_VER
qm template $VM_NUM

# deploy with
# qm clone $VM_NUM $NEW_VM_NUM --name $NAME

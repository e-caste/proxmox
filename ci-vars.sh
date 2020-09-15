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
# the path to the cloud-init yaml user config file
# e.g. freenas:snippets/user.yaml
CI_YAML_PATH=

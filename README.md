# proxmox

Some script utilities to run from the root shell of a Proxmox node.  
My focus at the moment is in automating the instantiation of Kubernetes-capable Ubuntu server VMs via Cloud-Init.

Run `./cloud-init-template.sh` to create a VM template in Proxmox. This script references the variables contained in `ci-vars.sh`, so you will need to set those before running the script since no defaults are provided.  
You can then deploy a VM referencing the template with `qm clone $TEMPLATE_VM_ID $NEW_VM_ID --name $NEW_VM_NAME`.

The script above copies the contents of `k8s/cloud-init-user.yaml` to a Cloud-Init dedicated volume mounted to the VM in a `nocloud` configuration to install Docker, kubeadm, kubelet and kubectl to the VM.  
The IPv4 address of the VM is set via DHCP, and it is reported in the Summary section of the Proxmox web GUI leveraging the customly installed `qemu-guest-agent` systemd service.

#!/bin/bash
#set -eux

echo "K3D cluster name: "
read name

echo "K3D number of agents: "
read number

if [[ "$number" =~ ^[0-9]+(\.[0-9]+)?$ ]]
then
   echo "OK - You provided valid value for agents count"
   echo "Creating cluster $name with $number agents"
   #k3d cluster create $name --k3s-arg "--disable=traefik@server:0" --k3s-arg "--disable=servicelb@server:0" --no-lb -a $number
   # lb feature needed cause service wasn't accessibled externally
   k3d cluster create $name --k3s-arg "--disable=traefik@server:0" -a $number
else
   echo "Error - please provide decimal number of agents count!"
fi
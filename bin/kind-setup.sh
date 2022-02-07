#!/bin/bash
#set -eux

echo "Kind cluster name: "
read name

kind create cluster --name $name --config ./config/kind.yaml
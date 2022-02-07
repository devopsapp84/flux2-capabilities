#!/bin/bash

#
# Script for Ubuntu/Debian/RHEL/Rockylinux/Fedora/CentOS
#

# Vars
platform=$(uname -m)
os=$(grep ID_LIKE /etc/*-release |grep ID_LIKE | awk -F '=' '{print $2}' | sed 's/"//g')


if [ $platform == x86_64 ]; then
  marked="amd64"
elif [ $platform == aarch64 ]; then
  marked="arm64"
fi

f_prereq () {
if [[ $os =~ "rhel"  || $os =~ "centos"  || $os =~ "fedora" ]]; then
  echo "RedHat family"

  echo "Git installation..."
  sudo yum -y install git

  echo "Docker installation..."
  sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
  sudo yum install -y yum-utils
  sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
  sudo yum install docker-ce docker-ce-cli containerd.io

  echo "Make sure that docker is starting automatically"
  sudo systemctl restart docker
  sudo systemctl enable docker
  sudo systemctl is-enabled docker
  sudo systemctl status docker

  echo "Sanity check run test container"
  sudo docker run hello-world
  sudo docker rm -f hello-world

elif [[ $os =~ "debian" ]]; then
  echo "Debian family"
  
  echo "Git installation..."
  sudo apt-get install -y git
  echo "Docker installation..."
  sudo apt-get update -y
  sudo apt-get install docker.io -y

  echo "Make sure that docker is starting automatically"
  sudo systemctl restart docker
  sudo systemctl enable docker
  sudo systemctl is-enabled docker
  sudo systemctl status docker

  echo "Sanity check run test container"
  sudo docker run hello-world
  sudo docker rm -f hello-world


else
  echo "Script not supporting your OS! Please use RedHat or Debian OS family!"
fi
}

f_kind_and_tools () {

git --version
GIT_IS_AVAILABLE=$?
if [ $GIT_IS_AVAILABLE -eq 0 ]; then
  echo "OK - git command found"
else
  echo "ERROR - no git command found!"
  f_prereq;
fi

echo "HELM Installation"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo "Kind Installation"
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

echo "Kubectl installation"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$marked/kubectl"
chmod +x kubectl
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$marked/kubectl.sha256"
echo "$(<kubectl.sha256) kubectl" | sha256sum --check
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

echo "Kubectx & Kubens installation"
git clone https://github.com/ahmetb/kubectx /opt/kubectx
ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens
git clone https://github.com/ahmetb/kubectx.git ~/.kubectx
COMPDIR=$(pkg-config --variable=completionsdir bash-completion)
ln -sf ~/.kubectx/completion/kubens.bash $COMPDIR/kubens
ln -sf ~/.kubectx/completion/kubectx.bash $COMPDIR/kubectx

cat << EOF >> ~/.bash_profile
# Kubectl
source <(kubectl completion bash)
alias k='kubectl'
complete -F __start_kubectl k
export do="-o yaml --dry-run=client"
export gf="--grace-period=0 --force"

# kubectx tool
export PATH=~/.kubectx:\$PATH

# Kind
. <(kind completion bash)

# K3d
. <(k3d completion bash)
EOF
}
# execution
f_kind_and_tools;
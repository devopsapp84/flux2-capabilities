#!/bin/bash

curl -s https://fluxcd.io/install.sh | sudo bash

cat << EOF >> ~/.bash_profile
# FluxCD
. <(flux completion bash)
EOF

source ~/.bash_profile

flux --version
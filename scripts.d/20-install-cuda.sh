#!/bin/bash -e

CUDA_VERSION=${CUDA_VERSION:-11.7}
CUDA_MAJOR_VERSION=${CUDA_VERSION%.*}
CUDA_MINOR_VERSION=${CUDA_VERSION#*.}
UBUNTU_VERSION=$(lsb_release -a 2>&1 | grep Release | sed -E 's/^[a-z]+:\t//i')
UBUNTU_MAJOR_VERSION=${UBUNTU_VERSION%.*}
UBUNTU_MINOR_VERSION=${UBUNTU_VERSION#*.}
UBUNTU_VERSION_NODOT=${UBUNTU_VERSION/./}

curl -kLo /etc/apt/preferences.d/cuda-repository-pin-600 https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin

(
  cd /tmp/cudacache
  aria2c -x16 -s16 --auto-file-renaming=false --continue https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda-repo-ubuntu2204-11-7-local_11.7.0-515.43.04-1_amd64.deb -o cuda-repo.deb
  apt-get install -y --no-install-recommends ./cuda-repo.deb
)

cp /var/cuda-repo-ubuntu2204-11-7-local/cuda-*-keyring.gpg /usr/share/keyrings/
apt-get -y update
apt-get -y install -qq --no-install-recommends cuda

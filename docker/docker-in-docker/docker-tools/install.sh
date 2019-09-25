#!/bin/bash
#
# Copyright 2019 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eux

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -qqy --no-install-recommends install \
  apt-transport-https \
  build-essential \
  ca-certificates \
  curl \
  lsb-release \
  software-properties-common \
  unzip \
  wget \
  zip \
  jq

# install docker
DOCKER_VERSION=18.06.1
VERSION_SUFFIX="~ce~3-0~ubuntu"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) stable"
apt-get update
apt-get -qqy install docker-ce="${DOCKER_VERSION}${VERSION_SUFFIX}"

# install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/"$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)"/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

apt-get clean
rm -rf /var/lib/apt/lists/*

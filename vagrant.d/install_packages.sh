#!/bin/bash

set -e

export DEBIAN_FRONTEND='noninteractive'

PROJECT_NAME=$1

VIRTUALENV_NAME=${PROJECT_NAME}

HOME_DIR=/home/vagrant
PROJECT_DIR=${HOME_DIR}/${PROJECT_NAME}
VIRTUALENV_DIR=${HOME_DIR}/.virtualenvs/${PROJECT_NAME}
INSTALL_DIR=${PROJECT_DIR}/vagrant.d
DIST_DIR=${INSTALL_DIR}/dist

systemd-run --property="After=apt-daily.service apt-daily-upgrade.service" --wait /bin/true

cat ${DIST_DIR}/etc/apt/source.list > /etc/apt/source.list

apt-get update -y

apt-get install -y software-properties-common
add-apt-repository ppa:apt-fast/stable
apt-get update -y

debconf-set-selections <<< "apt-fast apt-fast/maxdownloads string 16"
debconf-set-selections <<< "apt-fast apt-fast/dlflag boolean true"
debconf-set-selections <<< "apt-fast apt-fast/aptmanager string apt-get"
apt-get install -y apt-fast

#Ставим пакеты
apt-fast install -y build-essential sudo md5deep uuid zip unzip curl dirmngr cmake language-pack-en-base \
python-pip gdb nano rsync

pip install conan

sudo -u vagrant bash << EOF
  cd ~/merge-xlsx
  conan profile new default --detect
  conan profile update settings.compiler.libcxx=libstdc++11 default
  conan remote add conan-community https://api.bintray.com/conan/conan-community/conan
  conan remote add shajeenahmed https://api.bintray.com/conan/shajeenahmed/conan
  mkdir cmake-conan
  conan install . --install-folder=cmake-conan
  mkdir -p cmake-build/output
  cd cmake-build
  cmake .. -DCMAKE_INSTALL_PREFIX=output
  make
  make install
  export PATH=$PATH:~/merge-xlsx/cmake-build/output
  merge-xlsx --help
EOF
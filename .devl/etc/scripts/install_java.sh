#!/bin/bash

vagrant_build_log=/home/ubuntu/kibana/vm_build.log

echo -e "\n--- Installing java 8 ---\n"

add-apt-repository -y ppa:webupd8team/java >> $vagrant_build_log 2>&1

apt-get update >> $vagrant_build_log 2>&1

echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections

sudo apt-get -y install oracle-java8-installer >> $vagrant_build_log 2>&1
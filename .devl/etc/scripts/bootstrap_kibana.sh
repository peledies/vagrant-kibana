#! /usr/bin/env bash

vagrant_build_log=/home/ubuntu/kibana/vm_build.log

echo -e "\n--- Downloading kibana-5.4.0-linux-x86_64.tar.gz ---\n"
wget https://artifacts.elastic.co/downloads/kibana/kibana-5.4.0-linux-x86_64.tar.gz >> $vagrant_build_log 2>&1

echo -e "\n--- Verifying Checksum ---\n"
sha1sum kibana-5.4.0-linux-x86_64.tar.gz >> $vagrant_build_log 2>&1

echo -e "\n--- Unpacking Archive ---\n"
tar -xzf kibana-5.4.0-linux-x86_64.tar.gz --directory /home/ubuntu/kibana/kibana --strip-components=1 >> $vagrant_build_log 2>&1

#start the server
cd /home/ubuntu/kibana
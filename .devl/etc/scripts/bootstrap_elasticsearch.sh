#! /usr/bin/env bash

vagrant_build_log=/home/ubuntu/kibana/vm_build.log

echo -e "\n--- Downloading elasticsearch-5.4.0.tar.gz ---\n"
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.4.0.tar.gz >> $vagrant_build_log 2>&1

echo -e "\n--- Verifying Checksum ---\n"
sha1sum elasticsearch-5.4.0.tar.gz >> $vagrant_build_log 2>&1

echo -e "\n--- Unpacking Archive ---\n"
tar -xzf elasticsearch-5.4.0.tar.gz --directory /home/ubuntu/kibana/elasticsearch --strip-components=1 >> $vagrant_build_log 2>&1
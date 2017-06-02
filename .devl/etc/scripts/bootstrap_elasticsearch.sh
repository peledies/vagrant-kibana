#!/bin/bash

vagrant_build_log=/home/ubuntu/vm_build.log

echo -e "\n--- Installing Elasticsearch ---\n"

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - >> $vagrant_build_log 2>&1
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list >> $vagrant_build_log 2>&1
sudo apt-get update >> $vagrant_build_log 2>&1
sudo apt-get install -y elasticsearch >> $vagrant_build_log 2>&1

echo -e "\n--- Confguring Elasticsearch ---\n"

sudo sed -i "s/^#bootstrap.memory_lock/bootstrap.memory_lock/" /etc/elasticsearch/elasticsearch.yml
sudo sed -i "s/^#network.host: 192.168.0.1/network.host: localhost/" /etc/elasticsearch/elasticsearch.yml
sudo sed -i "s/^#http.port/http.port/" /etc/elasticsearch/elasticsearch.yml

sudo sed -i "s/^#LimitMEMLOCK/LimitMEMLOCK/" /usr/lib/systemd/system/elasticsearch.service 

sudo sed -i "s/^#MAX_LOCKED_MEMORY/MAX_LOCKED_MEMORY/" /etc/default/elasticsearch 

echo -e "\n--- Enabling Elasticsearch ---\n"

sudo systemctl daemon-reload >> $vagrant_build_log 2>&1
sudo systemctl enable elasticsearch >> $vagrant_build_log 2>&1
sudo systemctl start elasticsearch >> $vagrant_build_log 2>&1
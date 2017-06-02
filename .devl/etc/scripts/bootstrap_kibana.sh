#!/bin/bash

vagrant_build_log=/home/ubuntu/kibana/vm_build.log

echo -e "\n--- Installing Kibana ---\n"

apt-get install -y kibana >> $vagrant_build_log 2>&1

echo -e "\n--- Configuring Kibana ---\n"

sudo sed -i "s/^#server.port/server.port/" /etc/kibana/kibana.yml
sudo sed -i "s/^#server.host/server.host/" /etc/kibana/kibana.yml
sudo sed -i "s/^#elasticsearch.url/elasticsearch.url/" /etc/kibana/kibana.yml

echo -e "\n--- Enabling Kibana ---\n"

sudo systemctl enable kibana >> $vagrant_build_log 2>&1
sudo systemctl start kibana >> $vagrant_build_log 2>&1
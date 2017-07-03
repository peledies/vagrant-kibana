#!/bin/bash

vagrant_build_log=/home/ubuntu/kibana/vm_build.log

echo -e "\n--- Installing Nginx ---\n"

sudo apt-get install -y nginx apache2-utils >> $vagrant_build_log 2>&1

echo -e "\n--- Creating Virtualhost ---\n"

cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;
 
    server_name elk.local;
 
    location / {
        proxy_pass http://localhost:5601;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/ >> $vagrant_build_log 2>&1

cat <<EOF > /etc/nginx/sites-available/elastic
server {
    listen 81;

    server_name elastic.local;

    location / {
        proxy_pass http://localhost:9200;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF
ln -s /etc/nginx/sites-available/elastic /etc/nginx/sites-enabled/ >> $vagrant_build_log 2>&1

echo -e "\n--- Enabling Nginx ---\n"
systemctl enable nginx >> $vagrant_build_log 2>&1
systemctl restart nginx >> $vagrant_build_log 2>&1
#!/bin/bash

vagrant_build_log=/home/ubuntu/kibana/vm_build.log

echo -e "\n--- Installing Logstash ---\n"

apt-get install -y logstash >> $vagrant_build_log 2>&1

echo -e "\n--- Generating Logstash SSL Cert ---\n"

printf "\n192.168.33.3 elk-master" | sudo tee -a /etc/hosts >> $vagrant_build_log 2>&1

cd /etc/logstash/
openssl req -subj /CN=elk-master -x509 -days 3650 -batch -nodes -newkey rsa:4096 -keyout logstash.key -out logstash.crt >> $vagrant_build_log 2>&1

echo -e "\n--- Copying SSL Cert to project root ---\n"
cp /etc/logstash/logstash.crt /home/ubuntu/kibana/

echo -e "\n--- Configuring Logstash ---\n"

cat <<EOF > /etc/logstash/conf.d/filebeat-input.conf
input {
  beats {
    port => 5443
    type => syslog
    ssl => true
    ssl_certificate => "/etc/logstash/logstash.crt"
    ssl_key => "/etc/logstash/logstash.key"
  }
}
EOF

cat <<EOF > /etc/logstash/conf.d/syslog-filter.conf
filter {
  if [type] == "syslog" {
    grok {
      match => { "message" => "%{SYSLOGTIMESTAMP:syslog_timestamp} %{SYSLOGHOST:syslog_hostname} %{DATA:syslog_program}(?:\[%{POSINT:syslog_pid}\])?: %{GREEDYDATA:syslog_message}" }
      add_field => [ "received_at", "%{@timestamp}" ]
      add_field => [ "received_from", "%{host}" ]
    }
    date {
      match => [ "syslog_timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss" ]
    }
  }
}
EOF

cat <<EOF > /etc/logstash/conf.d/output-elasticsearch.conf
output {
  elasticsearch { hosts => ["localhost:9200"]
    hosts => "localhost:9200"
    manage_template => false
    index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
    document_type => "%{[@metadata][type]}"
  }
}
EOF

echo -e "\n--- Enabling Logstash ---\n"

sudo systemctl enable logstash >> $vagrant_build_log 2>&1
sudo systemctl start logstash >> $vagrant_build_log 2>&1
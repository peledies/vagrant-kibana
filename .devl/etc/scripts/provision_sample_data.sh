#!/bin/bash
#https://github.com/elastic/examples/tree/master/ElasticStack_NGINX

#DISABLE LOGSTASH PROVISIONER FILE CREATION PARTS

echo -e "\n--- Creating Sample Data ---\n"
mkdir -p ~/sample_data
cd ~/sample_data

echo -e "\n--- Getting Nginx Sample data, config, and template ---\n"
wget https://raw.githubusercontent.com/elastic/examples/master/ElasticStack_NGINX/nginx_logstash.conf > /dev/null 2>&1
wget https://raw.githubusercontent.com/elastic/examples/master/ElasticStack_NGINX/nginx_template.json > /dev/null 2>&1
wget https://raw.githubusercontent.com/elastic/examples/master/ElasticStack_NGINX/nginx_logs > /dev/null 2>&1

echo -e "\n--- Moving template and config ---\n"
sudo cp nginx_template.json /etc/logstash/conf.d/
sudo cp nginx_logstash.conf /etc/logstash/conf.d/

echo -e "\n--- Importing 300,000 log lines into logstash (This will take a while)---\n"
sudo cat nginx_logs | sudo /usr/share/logstash/bin/logstash --path.settings /etc/logstash -f /etc/logstash/conf.d/nginx_logstash.conf > /dev/null 2>&1



#in kabana go to management > saved objects > import

#import this file
#wget https://raw.githubusercontent.com/elastic/examples/master/ElasticStack_NGINX/nginx_kibana.json

# Load a dashboard programmaticily discussion
# https://github.com/elastic/kibana/issues/333

# get a dashboard by name
# curl -s -X GET http://localhost:9200/.kibana/dashboard/Sample-Dashboard-for-nginx-Logs/_source > sample_dashboard.json
# 
# import a new dashboard from json file
# curl -X PUT http://localhost:9200/.kibana/dashboard/deacsdashboard -T sample_dashboard.json


# sample_dashboard.json
# {
#   "title": "Programaticly created dashbord by deac",
#   "hits": 0,
#   "description": "",
#   "panelsJSON": "[{\"col\":7,\"id\":\"Traffic-by-Country-ampersand-OS\",\"row\":5,\"size_x\":6,\"size_y\":4,\"type\":\"visualization\"},{\"col\":4,\"id\":\"Traffic-vs.-Location\",\"row\":1,\"size_x\":9,\"size_y\":4,\"type\":\"visualization\"},{\"col\":1,\"id\":\"Unique-Visits\",\"row\":5,\"size_x\":3,\"size_y\":2,\"type\":\"visualization\"},{\"col\":1,\"id\":\"Non-200-Response-Code-vs.-Time\",\"row\":13,\"size_x\":12,\"size_y\":4,\"type\":\"visualization\"},{\"col\":4,\"id\":\"Total-Requests-by-City\",\"row\":5,\"size_x\":3,\"size_y\":4,\"type\":\"visualization\"},{\"col\":1,\"id\":\"Total-Requests\",\"row\":7,\"size_x\":3,\"size_y\":2,\"type\":\"visualization\"},{\"col\":1,\"id\":\"Bytes-vs.-Time\",\"row\":9,\"size_x\":12,\"size_y\":4,\"type\":\"visualization\"},{\"col\":1,\"id\":\"Nginx-Dashboard\",\"row\":1,\"size_x\":3,\"size_y\":4,\"type\":\"visualization\"}]",
#   "optionsJSON": "{\"darkTheme\":true}",
#   "uiStateJSON": "{}",
#   "version": 1,
#   "timeRestore": true,
#   "timeTo": "2015-06-10T19:10:56.990Z",
#   "timeFrom": "2015-05-10T19:10:56.990Z",
#   "kibanaSavedObjectMeta": {
#     "searchSourceJSON": "{\"filter\":[{\"query\":{\"query_string\":{\"analyze_wildcard\":true,\"query\":\"*\"}}}]}"
#   }
# }


#curl -X POST --header "Content-Type:application/json" --header "Accept: application/json" 'https://localhost:9200/elasticsearch/.kibana/dashboard/_search' --data '{"query":{"match_all":{}}}'
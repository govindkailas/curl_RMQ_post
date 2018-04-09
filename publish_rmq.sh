#!/bin/bash
#############################################################################################################
# NAME........... publish_rmq.sh
# Project .......
# AUTHOR......... Govind 
# DATE........... Monday, April 09, 2018
# PURPOSE........ Push the NFS monitoring alerts to RMQ
# HISTORY ....... Created the initial draft
#
#############################################################################################################
#set your RMQ variables here
rmq_url=my.domain.com
user= #Your user name here
pass= # Your password here
exchange= #mention the RMQ Queue name here

#create the json payload for creating the alert
#eventtype can be CREATE or CLEAR
#first_occurance is date time in UTC
# payload key/values must be formated/escaped properly

echo '
{"properties":{"delivery_mode":2},"routing_key":"JWT",
  "payload":"{
   \"alertnotes\":\"NFS Mount missing\",
   \"device\":\"'"$(hostname)"'\",
   \"servicename\":\"NFS Mount\",
   \"eventsource\":\"NFS monitoring\",
   \"message\":\"Docker NFS mount missing\",
   \"last_occurance\":\"'"$(date -u +'%Y-%m-%d %H:%M:%S')"'\",
   \"first_time\":\"'"$(date -u +'%Y-%m-%d %H:%M:%S')"'\",
   \"eventgroups\":\"IT-Ops\",
   \"severity\":\"3\",
   \"eventtype\": \"CREATE\",
   \"eventid\": \"123456789012345678901234\"
}",
"payload_encoding":"string"
}' >payload.json

#POST/Publish it to RMQ # Note: RMQ api access should be enabled (port#15672)
curl -s -u ${user}:${pass} -H "Accept: application/json" -H "Content-Type:application/json" -X POST -d @payload.json http://${rmq_url}:15672/api/exchanges/%2f/${exchange}/publish


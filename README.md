# curl_RMQ_post

# How to POST a JSON payload to Rabbit MQ using curl??


```
curl -X POST -H "Content-Type: application/json" -d @Payload.json RMQ_URL
```

so for example:

```
rmq_url=MY_RMQ_URL.com
user=USER_NAME
pass=PASSWD
exchange=MY_QUEUE_NAME

# Note: RMQ api access should be enabled (port#15672)
curl -s -u ${user}:${pass} -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data '{"properties":{"delivery_mode":2},"routing_key":"JWT","payload":"{\"sample\":\"load\"}","payload_encoding":"string"}' http://${rmq_url}:15672/api/exchanges/%2f/${exchange}/publish

```

If your payload is huge, consider posting it as a file.
You can use this  `curl -X POST -H "Content-Type: application/json" -d @FILENAME DESTINATION`) to specify payload as a file instead.

```
#POST/Publish it to RMQ
curl -s -u ${user}:${pass} -H "Accept: application/json" -H "Content-Type:application/json" -X POST -d @payload.json http://${rmq_url}:15672/api/exchanges/%2f/${exchange}/publish

``` 

More details on generating the json file is mentioned in the bash script.

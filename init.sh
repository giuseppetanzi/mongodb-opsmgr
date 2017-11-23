#!/bin/bash

# Initiate replica set configuration
# echo "Configuring the MongoDB Replica Set"
# mongo --host mongod-0.mongodb-service --eval 'rs.initiate({_id: "MainRepSet", version: 1, members: [ {_id: 0, host: "mongod-0.mongodb-service:27017"}, {_id: 1, host: "mongod-1.mongodb-service:27017"}, {_id: 2, host: "mongod-2.mongodb-service:27017"} ]});'

# Wait a bit until the replica set should have a primary ready
# echo "Waiting for the Replica Set to initialise..."
sleep 5 
# mongo --host mongod-0.mongodb-service --eval 'rs.status();'

LOGFILE="/opt/mongodb/mms/logs/docker-started-mms.log"

echo Running $@

nohup "$@" > $LOGFILE 2>&1 &

sleep 3
tail -F $LOGFILE & wait ${!}


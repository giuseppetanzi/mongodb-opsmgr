#!/bin/bash
set -x
# Initiate replica set configuration
echo "Configuring the MongoDB Replica Set"
EVAL="rs.initiate();for(i=0; i < $REPLICASETSIZE; i++) {servername=\"mongod-\"+i+\".mongodb-service:27017\";rs.add(servername);};"
echo $EVAL | mongo --host mongod-0.mongodb-service 

# Wait a bit until the replica set should have a primary ready
echo "Waiting for the Replica Set to initialise..."
sleep 10
mongo $REPLICSETNAME/mongod-0.mongodb-service --eval 'rs.status();'

LOGFILE="/opt/mongodb/mms/logs/docker-started-mms.log"

echo Running $@

nohup "$@" > $LOGFILE 2>&1 &
echo after
sleep 3
tail -F $LOGFILE & wait ${!}


#!/bin/bash

# Initiate replica set configuration

# Wait a bit until the replica set should have a primary ready

LOGFILE="/opt/mongodb/mms/logs/docker-started-mms.log"

echo Running $@

nohup "$@" > $LOGFILE 2>&1 &
echo after
sleep 3
tail -F $LOGFILE & wait ${!}


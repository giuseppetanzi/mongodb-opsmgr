#!/bin/bash

# Initiate replica set configuration

# Wait a bit until the replica set should have a primary ready

LOGFILE="/opt/mongodb/mms/logs/docker-started-mms.log"

sigterm_handler() {
  echo "AGENT-WRAPPER: Stopping mms service"
  /opt/mongodb/mms/bin/mongodb-mms stop
  kill -KILL 1 || true
  echo "AGENT-WRAPPER: Finished stopping mms processes"
  exit 143
}

# Register the above sigterm handler function
echo "AGENT-WRAPPER: Registering SIGTERM handler"
trap 'kill ${!}; sigterm_handler' SIGTERM

echo Running $@

nohup "$@" > $LOGFILE 2>&1 &
echo after
sleep 3
tail -F $LOGFILE & wait ${!}


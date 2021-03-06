#!/bin/bash

LOCUST_CMD="/usr/local/bin/locust"
LOCUST_OPTS="-f $SCENARIO_FILE --host=$TARGET_URL"
LOCUST_MODE=${LOCUST_MODE:-standalone}

if [ -z "$SCENARIO_FILE_URL" ]; then
  echo "=> Downloading scenario file from $SCENARIO_FILE_URL"
  curl -o $SCENARIO_FILE $SCENARIO_FILE_URL
fi

if [ "$LOCUST_MODE" = "master" ]; then
  LOCUST_OPTS="$LOCUST_OPTS --master"
elif [ "$LOCUST_MODE" = "slave" ]; then
  LOCUST_OPTS="$LOCUST_OPTS --slave --master-host=$MASTER_HOST"
fi

echo "=> Starting locust"
echo "$LOCUST_CMD $LOCUST_OPTS"

$LOCUST_CMD $LOCUST_OPTS

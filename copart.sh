 #!/bin/bash
PIDFILE=/home/ba/Desktop/RoR/skyscraper/tmp/pids/filter_copa.pid

if [ -f $PIDFILE ]
then
  PID=$(cat $PIDFILE)
  ps -p $PID > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo "Process already running"
    exit 1
  else
    ## Process not found assume not running
    echo $$ > $PIDFILE
    if [ $? -ne 0 ]
    then
      echo "Could not create PID file"
      exit 1
    fi
  fi
else
  echo $$ > $PIDFILE
  if [ $? -ne 0 ]
  then
    echo "Could not create PID file"
    exit 1
  fi
fi

/bin/bash -l -c 'cd home/ba/Desktop/RoR/skyscraper && bin/rails runner -e production '\''Copart.download_csv'\'''
rm $PIDFILE

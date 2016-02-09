#!/bin/sh
# This script generates load on the specified URL.

#Accepts a delay and a URL

while getopts :d:u: opt; do
  case $opt in
    d)  #set delay
      DELAY=$OPTARG
      #echo "DELAY = $DELAY"
      ;;
    u)  #set url
      URL=$OPTARG
      #echo "URL = $URL"
      ;;
    \?) #invalid arg
      echo "Invalid argument -$OPTARG"
      exit 1;
      ;;
  esac
done

if [ -z "$URL" ]; then
	echo "URL must be specified with -u";
	exit 1;
fi
 
#Default delay to 0 if not specified
if [ -z "$DELAY" ]; then
	DELAY=0;
fi

#echo "Delay: $DELAY";

#Check for RUNNING file to determine if load should be generated
if [ ! -f "RUNNING" ] ; then
	echo "Load test not running. Exiting...";
	exit 0;
fi

#Clean up the results log file if it exists
if [ -f results.log ] ; then
	echo "Cleaning up old results.log"
	rm -f results.log
fi

#TODO: Get fancier to prevent someone from stopping and starting the load during sleep interval
# and ending up with multiple load scripts continuing to run simultaneously. For example, could
# put the PID in RUNNING and either verify it here or have the calling script kill this process.

echo "Starting load to $URL";

while [ -f RUNNING ] ;
do
	curl -s $URL -w "\n"  >> results.log;
	sleep $DELAY;
done

echo "Done.";

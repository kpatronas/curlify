#!/bin/bash

FILEPATH=$PWD
EVENTS='create,delete,modify'
TS='%Y-%m-%dT%H:%M:%S'
URL=''
HTTP_METHOD='POST'
INOTIFY_PARAMETERS=''
CURL_PARAMETERS=''

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -e|--events)
      EVENTS="$2"
      shift
      shift
      ;;
    -p|--path)
      FILEPATH="$2"
      shift
      shift
      ;;
    -t|--ts)
      TS="$2"
      shift
      shift
      ;;
    -u|--url)
      URL="$2"
      shift
      shift
      ;;
    -m|--method)
      HTTP_METHOD="$2"
      shift
      shift
      ;;
    -c|--curl_parameters)
      CURL_PARAMETERS="$2"
      shift
      shift
      ;;
    -i|--inotify_parameters)
      INOTIFY_PARAMETERS="$2"
      shift
      shift
      ;;
  esac
done

if [ -z "${URL}" ];
then
    inotifywait $INOTIFY_PARAMETERS --timefmt $TS --format "{'ts':'%T','path':'%w','file':'%f','event':'%e'}" -m -r -e $EVENTS $FILEPATH
else
    inotifywait $INOTIFY_PARAMETERS --timefmt $TS --format "{'ts':'%T','path':'%w','file':'%f','event':'%e'}" -m -r -e $EVENTS $FILEPATH | xargs -I {} curl $CURL_PARAMETERS -X $HTTP_METHOD $URL -d {}
fi

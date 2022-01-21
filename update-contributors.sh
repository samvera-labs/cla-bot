#!/bin/bash

# download a CSV list of samvera contributors from a google sheet and convert to a JSON
# array for CLA-bot (https://github.com/marketplace/cla-bot-cla-automation)

function deliminate
{
  echo "["

  read LINE
  while [ "$LINE" ]; do
    echo -n "\"$LINE\""
    read LINE
    if [ "$LINE" ]; then
      echo ","
    else
      echo ""
    fi
  done

  echo "]"
}

SHEET_ID="1aLVIB6LVkRBWw5jA9D9D2eYBTjiPd0o4X9DxUOsD9o0"
URL="https://docs.google.com/spreadsheets/d/$SHEET_ID/export?format=csv&id=$SHEET_ID&gid=0"
curl -L -o contributors.csv "$URL"
cut -d, -f1 -s contributors.csv | sort | grep -v "^$" | deliminate > contributors.json

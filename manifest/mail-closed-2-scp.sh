#!/bin/bash

if [[ "$REMOTE_SERVER" == "" ]]; then
  echo "REMOTE_SERVER is not set"
  exit 1
fi

if [[ "$REMOTE_PATH" == "" ]]; then
  echo "REMOTE_PATH is not set"
  exit 1
fi

scp -r $HOME/mail-install $REMOTE_SERVER:$REMOTE_PATH

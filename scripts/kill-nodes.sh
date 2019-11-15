#!/bin/bash

source config.sh

echo "Killing anything named '$SUBSTRATE'"
ps aux | grep $SUBSTRATE | grep -v grep | awk '{ print $2 }' | xargs kill 2> /dev/null || echo no $SUBSTRATE running anyways
sleep 0.5

echo
echo "Is any such process still running? Then kill manually with 'kill -9 PID'."
echo "ps aux | grep "$SUBSTRATE
ps aux | grep $SUBSTRATE | grep -v grep 


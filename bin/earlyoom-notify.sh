#!/bin/bash

# Script to send a desktop notification when earlyoom kills a process.
# It uses the environment variables provided by earlyoom's -N flag.

# Use -u critical for urgency and -i for an icon.
# The body of the notification includes the info from earlyoom.
notify-send -u critical -i dialog-warning \
  "EarlyOOM: Process Killed"
  "Name: $EARLYOOM_NAME
PID: $EARLYOOM_PID
UID: $EARLYOOM_UID
Command: $EARLYOOM_CMDLINE"

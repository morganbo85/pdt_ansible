#!/bin/bash

mingigs=5
avail=$(df -BG / | awk 'NR==2 {print $4+0}')  # Extract available GB as an integer
topicurl=44.217.53.30/itst_aws

if (( avail < mingigs )); then
  curl \
    -d "Only $avail GB available on the / disk. Better clean that up." \
    -H "Title: Low disk space alert on $(hostname)" \
    -H "Priority: high" \
    -H "Tags: warning,cd" \
    $topicurl
fi

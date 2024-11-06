#!/bin/bash

mingigs=10
avail=$(df -BG /mnt/backup | awk 'NR==2 {print $4+0}')  # Extract available GB as an integer
topicurl=198.58.105.88:8080/itst

if (( avail < mingigs )); then
  curl \
    -d "Only $avail GB available on the /mnt/backup disk. Better clean that up." \
    -H "Title: Low disk space alert on $(hostname)" \
    -H "Priority: high" \
    -H "Tags: warning,cd" \
    $topicurl
fi

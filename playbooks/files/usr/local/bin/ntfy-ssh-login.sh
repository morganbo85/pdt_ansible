#!/bin/bash

TOPIC_URL=172-234-150-15.ip.linodeusercontent.com/itst

if [ "${PAM_TYPE}" = "open_session" ]; then
  curl -H tags:warning -H prio:high -d "SSH login to $(hostname): ${PAM_USER} from ${PAM_RHOST}" "${TOPIC_URL}"
fi

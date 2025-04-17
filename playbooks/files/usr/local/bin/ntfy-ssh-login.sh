#!/bin/bash

TOPIC_URL=alert.morganbo.com/nKYocnvUVRgzYByJ

if [ "${PAM_TYPE}" = "open_session" ]; then
  curl -H tags:warning -H prio:high -d "SSH login to $(hostname): ${PAM_USER} from ${PAM_RHOST}" "${TOPIC_URL}"
fi

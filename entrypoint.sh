#!/bin/bash

set -e

if [ "${S3_S3V4}" = "yes" ]; then
    aws configure set default.s3.signature_version s3v4
fi

if [ -z "${SCHEDULE}" ]; then
  /bin/bash /backup.sh
else
  echo "${SCHEDULE} /bin/bash /backup.sh" > /etc/crontab.backup
  exec supercronic -debug -prometheus-listen-address 0.0.0.0 /etc/crontab.backup
fi

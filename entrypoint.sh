#!/bin/bash

USER_NAME=${USER:-root}
USER_ID=${LOCAL_USER_ID:-0}
GROUP_ID=${LOCAL_GROUP_ID:-0}

if [ "${USER_ID}" -ne "0" ]; then
  groupadd -g ${GROUP_ID} ${USER_NAME} &> /dev/null
  useradd --shell /bin/bash -M -u ${USER_ID} -g ${GROUP_ID} -o -c "" ${USER_NAME}
  usermod -aG sudo ${USER_NAME}

  /usr/local/bin/gosu ${USER_NAME} /bin/bash -c "$@"
else
  exec "$@"
fi

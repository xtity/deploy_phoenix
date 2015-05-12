#!/bin/bash
PHOENIX_APP_VERSION=`cat /usr/local/src/phoenix/app/$PHOENIX_APP_NAME/VERSION`
# touch /root/tmp/$PHOENIX_APP_VERSION.txt
/usr/local/src/phoenix/app/rel/${PHOENIX_APP_NAME}/bin/${PHOENIX_APP_NAME} upgrade $PHOENIX_APP_VERSION
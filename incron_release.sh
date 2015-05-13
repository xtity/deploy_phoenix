#!/bin/bash
PHOENIX_APP_VERSION=`cat /usr/local/src/phoenix/${PHOENIX_APP_NAME}/current/${PHOENIX_APP_NAME}/VERSION`

cp -rp /usr/local/src/phoenix/${PHOENIX_APP_NAME}/current/${PHOENIX_APP_NAME}/rel/${PHOENIX_APP_NAME}/releases/${PHOENIX_APP_VERSION} /usr/local/app/phoenix/${PHOENIX_APP_NAME}/rel/${PHOENIX_APP_NAME}/releases/
cp /usr/local/src/phoenix/${PHOENIX_APP_NAME}/current/${PHOENIX_APP_NAME}/rel/${PHOENIX_APP_NAME}/${PHOENIX_APP_NAME}-${PHOENIX_APP_VERSION}.tar.gz /usr/local/app/phoenix/${PHOENIX_APP_NAME}/rel/${PHOENIX_APP_NAME}/releases/${PHOENIX_APP_VERSION}/${PHOENIX_APP_NAME}.tar.gz

cd /usr/local/app/phoenix/${PHOENIX_APP_NAME}
rel/${PHOENIX_APP_NAME}/bin/${PHOENIX_APP_NAME} upgrade $PHOENIX_APP_VERSION
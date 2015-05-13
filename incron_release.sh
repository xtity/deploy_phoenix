#!/bin/bash
# PHOENIX_APP_VERSION=`cat /usr/local/src/phoenix/${PHOENIX_APP_NAME}/VERSION`
export PHOENIX_APP_VERSION=`cat /usr/local/src/phoenix/${PHOENIX_APP_NAME}/VERSION`

cd /usr/local/src/phoenix/${PHOENIX_APP_NAME}
yes | mix local.hex && yes | mix local.rebar && npm install && npm install -g brunch && mix do deps.get && brunch build && mix phoenix.digest && MIX_ENV=prod mix release

cp -rp /usr/local/src/phoenix/${PHOENIX_APP_NAME}/rel/${PHOENIX_APP_NAME}/releases/${PHOENIX_APP_VERSION} /usr/local/app/phoenix/${PHOENIX_APP_NAME}/rel/${PHOENIX_APP_NAME}/releases/
cp /usr/local/src/phoenix/${PHOENIX_APP_NAME}/rel/${PHOENIX_APP_NAME}/${PHOENIX_APP_NAME}-${PHOENIX_APP_VERSION}.tar.gz /usr/local/app/phoenix/${PHOENIX_APP_NAME}/rel/${PHOENIX_APP_NAME}/releases/${PHOENIX_APP_VERSION}/${PHOENIX_APP_NAME}.tar.gz

cd /usr/local/app/phoenix/${PHOENIX_APP_NAME}
rel/${PHOENIX_APP_NAME}/bin/${PHOENIX_APP_NAME} upgrade $PHOENIX_APP_VERSION
########## OS ##########
FROM xtity/docker-centos7-elixir
########## OS ##########


########## PHOENIX ##########
ENV PHOENIX_APP_NAME deploy_phoenix
ENV PHOENIX_APP_REPO https://github.com/xtity/deploy_phoenix.git
ENV PHOENIX_APP_PORT 4000

# Expose phoenix app port
EXPOSE ${PHOENIX_APP_PORT}

# Install original phoenixframework
# RUN mkdir -p /usr/local/src/phoenix/origin
# WORKDIR /usr/local/src/phoenix/origin
# RUN git clone https://github.com/phoenixframework/phoenix.git
# WORKDIR /usr/local/src/phoenix/origin/phoenix/installer
# RUN MIX_ENV=prod mix archive.build
# RUN yes | mix archive.install

# Install phoenix app
RUN mkdir -p /usr/local/src/phoenix/${PHOENIX_APP_NAME}/current
WORKDIR /usr/local/src/phoenix/${PHOENIX_APP_NAME}/current

# Create new phoenix app
#RUN mix phoenix.new ${PHOENIX_APP_NAME}

# Clone phoenix app
RUN git clone ${PHOENIX_APP_REPO}

# Setup phoenix app
WORKDIR /usr/local/src/phoenix/${PHOENIX_APP_NAME}/current/${PHOENIX_APP_NAME}
# RUN npm install
# RUN npm install -g brunch

# # Add exrm dependency
# RUN sed -i "s/\({:cowboy,.*}\)]/\1, {:exrm, \"~> 0.14.16\"}]/g" mix.exs

# # Set phoenix server to start automatically
# RUN sed -i "s/^config\(.*\).Endpoint,/config \1.Endpoint, server: true,/g" config/prod.exs

# Compile phoenix(FOR dev)
#RUN yes | mix local.hex && yes | mix local.rebar && npm install && npm install -g brunch && mix do deps.get, compile
# Compile phoenix(FOR prod)
RUN yes | mix local.hex && yes | mix local.rebar && npm install && npm install -g brunch && mix do deps.get && brunch build && mix phoenix.digest && MIX_ENV=prod mix release

# Release app directory
RUN mkdir -p /usr/local/app/phoenix/${PHOENIX_APP_NAME}
WORKDIR /usr/local/app/phoenix/${PHOENIX_APP_NAME}
RUN cp -a /usr/local/src/phoenix/${PHOENIX_APP_NAME}/current/${PHOENIX_APP_NAME}/rel .
########## PHOENIX ##########


########## INCRON ##########
# RUN /bin/bash -c service incrond start
# RUN touch /vat/spool/incron/incron.root
# RUN /usr/local/src/phoenix/app/${PHOENIX_APP_NAME}/rel/${PHOENIX_APP_NAME}/releases/${PHOENIX_APP_VERSION}/${PHOENIX_APP_NAME}.tar.gz IN_CREATE,IN_MODIFY /usr/local/src/phoenix/app/rel/${PHOENIX_APP_NAME}/bin/${PHOENIX_APP_NAME} upgrade "${PHOENIX_APP_VERSION}"
# RUN echo "/usr/local/src/phoenix/app/${PHOENIX_APP_NAME}/rel/${PHOENIX_APP_NAME}/releases/${PHOENIX_APP_VERSION} IN_CREATE /usr/local/src/phoenix/app/rel/${PHOENIX_APP_NAME}/bin/${PHOENIX_APP_NAME} upgrade '${PHOENIX_APP_VERSION}'" >> /var/spool/incron/root
# RUN echo "/usr/local/src/phoenix/app/${PHOENIX_APP_NAME}/rel/${PHOENIX_APP_NAME}/releases/${PHOENIX_APP_VERSION} IN_CREATE /usr/local/src/phoenix/app/rel/${PHOENIX_APP_NAME}/bin/${PHOENIX_APP_NAME} upgrade '${PHOENIX_APP_VERSION}'" >> /var/spool/incron/root

# RUN echo "/root IN_CREATE touch /root/tmp/yo.txt" >> /var/spool/incron/root
# RUN echo "/usr/local/src/phoenix/app/${PHOENIX_APP_NAME}/rel/${PHOENIX_APP_NAME}/releases IN_CREATE touch /root/tmp/yo.txt" >> /var/spool/incron/root
# ADD incron_release.sh /usr/local/src/phoenix/app/${PHOENIX_APP_NAME}/incron_release.sh
# RUN echo "/usr/local/app/phoenix/${PHOENIX_APP_NAME}/rel/${PHOENIX_APP_NAME}/releases IN_CREATE /bin/bash /usr/local/src/phoenix/${PHOENIX_APP_NAME}/current/${PHOENIX_APP_NAME}/incron_release.sh" >> /var/spool/incron/root
RUN echo "/usr/local/src/phoenix/${PHOENIX_APP_NAME}/VERSION IN_MODIFY /bin/bash /usr/local/src/phoenix/${PHOENIX_APP_NAME}/incron_release.sh" >> /var/spool/incron/root
# RUN echo "/usr/local/src/phoenix/app/${PHOENIX_APP_NAME}/rel/${PHOENIX_APP_NAME}/releases/$PHOENIX_APP_VERSION/$PHOENIX_APP_NAME.tar.gz IN_CREATE touch /root/tmp/yo.txt" >> /var/spool/incron/root
########## INCRON ##########


########## ON BOOT ##########
# Run Phoenix on Cowboy server(FOR dev)
#CMD ["/bin/bash", "-c", "mix phoenix.server"]
# Run Phoenix on Cowboy server(FOR prod)
# CMD ["/bin/bash", "-c", "/usr/sbin/incrond"]
CMD ["/bin/bash", "-c", "/usr/sbin/incrond start && PORT=${PHOENIX_APP_PORT} rel/${PHOENIX_APP_NAME}/bin/${PHOENIX_APP_NAME} foreground"]
# CMD ["/bin/bash", "-c", "/usr/sbin/incrond start -n"]
########## ON BOOT ##########



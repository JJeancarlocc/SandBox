FROM elixir:1.9 AS builder
ENV MIX_ENV=prod
WORKDIR /usr/local/hello_jc
# This step installs all the build tools we'll need
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
    apt-get install -y nodejs && \
    mix local.rebar --force && \
    mix local.hex --force
# Copies our app source code into the build container
COPY . .
# Compile Elixir
RUN mix do deps.get, deps.compile, compile
# Compile Javascript
RUN cd assets \
    && npm install \
    && ./node_modules/webpack/bin/webpack.js --mode production \
    && cd .. \
    && mix phx.digest
# Build Release
RUN mkdir -p /opt/release \
    && mix release \
    && mv _build/${MIX_ENV}/rel/hello_jc /opt/release
# Create the runtime container
FROM erlang:22 as runtime
WORKDIR /usr/local/hello_jc
COPY --from=builder /opt/release/hello_jc .
CMD [ "bin/hello_jc", "start" ]
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=2 \
CMD nc -vz -w 2 localhost 4000 || exit 1
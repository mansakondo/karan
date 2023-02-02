# syntax = docker/dockerfile:experimental
ARG RUBY_VERSION=3.0.1
ARG VARIANT=jemalloc-slim
FROM quay.io/evl.ms/fullstaq-ruby:${RUBY_VERSION}-${VARIANT} as base

ARG NODE_VERSION=16
ARG BUNDLER_VERSION=2.2.16

ARG RAILS_ENV=production
ENV RAILS_ENV=${RAILS_ENV}

ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}

ARG DATABASE_URL
ENV DATABASE_URL ${DATABASE_URL}

ARG BONSAI_URL
ENV BONSAI_URL ${BONSAI_URL}

ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

ARG BUNDLE_WITHOUT=development:test
ARG BUNDLE_PATH=vendor/bundle
ENV BUNDLE_PATH ${BUNDLE_PATH}
ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}

RUN mkdir /app
WORKDIR /app
RUN mkdir -p tmp/pids

SHELL ["/bin/bash", "-c"]

RUN curl https://get.volta.sh | bash

ENV BASH_ENV ~/.bashrc
ENV VOLTA_HOME /root/.volta
ENV PATH $VOLTA_HOME/bin:/usr/local/bin:$PATH

RUN volta install node@${NODE_VERSION} && volta install yarn

FROM base as build_deps

ARG DEV_PACKAGES="git build-essential libpq-dev wget vim curl gzip xz-utils libsqlite3-dev"
ENV DEV_PACKAGES ${DEV_PACKAGES}

RUN --mount=type=cache,id=dev-apt-cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,id=dev-apt-lib,sharing=locked,target=/var/lib/apt \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y ${DEV_PACKAGES} \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

FROM build_deps as gems

RUN gem install -N bundler -v ${BUNDLER_VERSION}

COPY Gemfile* ./
RUN bundle install &&  rm -rf vendor/bundle/ruby/*/cache

FROM build_deps as node_modules

COPY package*json ./
COPY yarn.* ./

RUN if [ -f "yarn.lock" ]; then \
    yarn install; \
    elif [ -f "package-lock.json" ]; then \
    npm install; \
    else \
    mkdir node_modules; \
    fi

FROM base

ARG PROD_PACKAGES="postgresql-client file vim curl gzip libsqlite3-0"
ENV PROD_PACKAGES=${PROD_PACKAGES}

RUN --mount=type=cache,id=prod-apt-cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,id=prod-apt-lib,sharing=locked,target=/var/lib/apt \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    ${PROD_PACKAGES} \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY --from=gems /app /app
COPY --from=node_modules /app/node_modules /app/node_modules

ENV SECRET_KEY_BASE 1

COPY . .

RUN bundle exec rails assets:precompile
RUN bundle exec rails db:prepare

ENV PORT 8080

ARG SERVER_COMMAND="bundle exec puma -C config/puma.rb"
ENV SERVER_COMMAND ${SERVER_COMMAND}
CMD ${SERVER_COMMAND}

# ARG RUBY_VERSION=3.0.1
#
# FROM ruby:$RUBY_VERSION
#
# ARG BUNDLER_VERSION=2.2.16
# ARG NPM_VERSION=6.14.15
#
# RUN apt-get install curl
# RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
#
# RUN apt-get update
# RUN apt-get install -y git-core zlib1g-dev build-essential libssl-dev \
# libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev \
# libcurl4-openssl-dev software-properties-common libffi-dev nodejs
# RUN npm install npm@$NPM_VERSION -g
# RUN npm install yarn -g
#
# # RUN apt-get install -y autoconf automake libtool gcc bison tclsh xsltproc \
# # docbook docbook-xml docbook-xsl libxslt1-dev libgnutls28-dev libreadline-dev \
# # libwrap0-dev pkg-config libicu-dev make
# # RUN git clone --recursive https://github.com/indexdata/yaz.git
# # WORKDIR yaz
# # RUN ./buildconf.sh
# # RUN ./configure
# # RUN make
# # RUN make install
# # RUN ldconfig
#
# WORKDIR /myapp
# COPY . .
#
# RUN gem install -v $BUNDLER_VERSION bundler
# RUN bundle config without development:test
# RUN bundle install
#
# ENV RAILS_ENV=production
# ARG RAILS_MASTER_KEY
# RUN bundle exec rails assets:precompile
# RUN bundle exec rails db:prepare
#
# ENV PORT=8080
# ENV RAILS_LOG_TO_STDOUT=true
# ENV RAILS_SERVE_STATIC_FILES=true
#
# CMD bundle exec rails server

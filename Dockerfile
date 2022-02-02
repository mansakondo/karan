ARG RUBY_VERSION=3.0.1

FROM ruby:$RUBY_VERSION

ARG BUNDLER_VERSION=2.2.16
ARG NPM_VERSION=6.14.15

ARG RACK_ENV
ARG RAILS_ENV
ARG RAILS_MASTER_KEY
ARG RAILS_SERVE_STATIC_FILES

RUN apt-get install curl
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -

RUN apt-get update
RUN apt-get install -y git-core zlib1g-dev build-essential libssl-dev \
libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev \
libcurl4-openssl-dev software-properties-common libffi-dev nodejs
RUN npm install npm@$NPM_VERSION -g
RUN npm install yarn -g

# RUN apt-get install -y autoconf automake libtool gcc bison tclsh xsltproc \
# docbook docbook-xml docbook-xsl libxslt1-dev libgnutls28-dev libreadline-dev \
# libwrap0-dev pkg-config libicu-dev make
# RUN git clone --recursive https://github.com/indexdata/yaz.git
# WORKDIR yaz
# RUN ./buildconf.sh
# RUN ./configure
# RUN make
# RUN make install
# RUN ldconfig

WORKDIR /myapp
COPY . .

RUN gem install -v $BUNDLER_VERSION bundler
RUN bundle config without development:test
RUN bundle install

RUN bundle exec rails assets:precompile

CMD ["bash"]

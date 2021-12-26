# Dockerfile
FROM ruby:2.7

ADD . /usr/src/app

WORKDIR /usr/src/app

RUN bundle config without test production
RUN bundle install

CMD rails server -b 0.0.0.0

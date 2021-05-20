FROM ruby:2.6.7

# Prerequisites
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -q \
    && apt-get install -y nodejs yarn cron

# Cache Gems
WORKDIR /tmp

ADD Gemfile .
ADD Gemfile.lock .

RUN bundle install

# Copy App
WORKDIR /usr/src/app

ADD . /usr/src/app

# Precompile assets
RUN bin/yarn install
RUN bin/rails assets:precompile

# Expose port 3000 to other containers (Note: not external devices such as our workstation)
ENV PORT 3000
EXPOSE $PORT

CMD ./docker-entrypoint.sh

# Dockerfile
FROM ruby:2.7

# Cache Gems
WORKDIR /tmp

ADD Gemfile .
ADD Gemfile.lock .

RUN bundle install

WORKDIR /usr/src/app

# Copy app code into the image
ADD . /usr/src/app

# Precompile assets
RUN bin/rails assets:precompile

# Expose port 3000 to other containers (Note: not external devices such as our workstation)
ENV PORT 3000

EXPOSE $PORT

# Run the docker-entrypoint file
CMD ./docker-entrypoint.sh

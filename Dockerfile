# syntax=docker/dockerfile:1.3-labs
FROM ruby:2.7

# Install NodeJS and YARN
RUN <<EOF
curl -fsSL https://deb.nodesource.com/setup_17.x | bash -
apt-get install -y nodejs

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update && apt-get install -y yarn
EOF

# Cache Gems
WORKDIR /tmp

ADD Gemfile .
ADD Gemfile.lock .

RUN bundle install

WORKDIR /usr/src/app

# Copy app code into the image
ADD . /usr/src/app

# Precompile assets
# RUN bin/rails assets:precompile

# Expose port 3000 to other containers (Note: not external devices such as our workstation)
ENV PORT 3000

EXPOSE $PORT

# Run the docker-entrypoint file
CMD ./docker-entrypoint.sh

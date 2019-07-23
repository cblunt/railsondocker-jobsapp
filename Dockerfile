# Dockerfile
FROM ruby:2.6

# Prerequisites
RUN apt-get update -q && \
    apt-get install -y nodejs cron

# Install chrome
RUN curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /chrome.deb \
  && dpkg -i /chrome.deb || apt-get install -yf \
  && rm /chrome.deb

# Install chromedriver using the build argument specified version, or the
# given default
ARG CHROMEDRIVER_VERSION=75.0.3770.90

RUN apt-get install -y libgconf2-dev \
    && curl https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip -o /tmp/chromedriver.zip \
    && unzip /tmp/chromedriver.zip -d /usr/local/bin/ \
    && rm /tmp/chromedriver.zip \
    && chmod +x /usr/local/bin/chromedriver

# Cache Gems
WORKDIR /tmp

ADD Gemfile .
ADD Gemfile.lock .

RUN bundle install --jobs `nproc`

# Copy App
WORKDIR /usr/src/app

ADD . /usr/src/app

# Precompile assets
RUN bundle exec rails assets:precompile

# Expose port 3000 to other containers (Note: not external devices such as our workstation)
ENV PORT 3000
EXPOSE $PORT

CMD ./docker-entrypoint.sh

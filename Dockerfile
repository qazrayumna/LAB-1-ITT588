
FROM ruby:3.4

RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libyaml-dev \
    chromium \
    chromium-driver && \
    rm -rf /var/lib/apt/lists/*

RUN gem install rails

WORKDIR /app

EXPOSE 3000

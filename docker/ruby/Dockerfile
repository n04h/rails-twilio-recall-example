FROM ruby:3.0.3-alpine3.14

ENV HOME="/app" \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    RUBYOPT='-W:deprecated'

WORKDIR ${HOME}

COPY Gemfile* ./

# apk update
RUN apk update && apk upgrade \
    && apk add --update --no-cache --virtual=.build-dependencies \
    build-base \
    curl-dev \
    ruby-dev \
    git \
    cmake \
    && apk add --update --no-cache \
    bash \
    mysql-dev \
    tzdata \
    shared-mime-info

# Install dependencies
RUN bundle install -j4

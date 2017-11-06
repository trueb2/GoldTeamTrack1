FROM ruby:2.4

RUN apt-get update && \
  apt-get install -y nodejs \
                     vim \
                     mysql-client \
                     --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

RUN mkdir /noxious
WORKDIR /noxious
ADD Gemfile /noxious/Gemfile
ADD Gemfile.lock /noxious/Gemfile.lock
RUN bundle install
ADD . /noxious

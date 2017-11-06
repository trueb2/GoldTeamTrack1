FROM ruby:2.3.3
RUN apt-get update -qq && \
  apt-get install -y build-essential nodejs mysql-client vim
RUN mkdir /noxious
WORKDIR /noxious
ADD Gemfile /noxious/Gemfile
ADD Gemfile.lock /noxious/Gemfile.lock
RUN bundle install
ADD . /noxious

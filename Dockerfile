FROM ruby:latest

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

COPY ./Gemfile /usr/src/app
COPY ./Gemfile.lock /usr/src/app

RUN bundle install

COPY . /sr/src/app

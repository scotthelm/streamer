FROM ruby:latest

RUN mkdir /usr/src/app
WORKDIR /usr/src/app


COPY . /usr/src/app

FROM ruby:3.0-buster

COPY . .

RUN bundle install

FROM ruby:3

COPY . .

RUN bundle install

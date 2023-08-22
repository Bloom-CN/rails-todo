FROM ruby:2.7.6

WORKDIR /rails

COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock

RUN bundle install

# CMD ["rails", "server", "-b", "0.0.0.0"]

FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN gem install bundler

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

WORKDIR /app

RUN bundle install

CMD ["rails", "server", "-b", "0.0.0.0"]

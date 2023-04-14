FROM ruby:3.1.0

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

ENV RAILS_ENV=development

EXPOSE 3000

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]

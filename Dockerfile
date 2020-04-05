FROM ruby:2.6.1-alpine3.9

MAINTAINER Sascha Burku <sascha_burku@yahoo.de>

RUN apk update --no-cache && \
    apk upgrade && \
    apk add build-base postgresql-dev nodejs-current yarn && \
    rm -rf /var/cache/apk/*

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && bundle install -j4

COPY . .

RUN yarn upgrade

RUN chmod +x bin/entrypoint.sh

ENTRYPOINT ["/usr/src/app/bin/entrypoint.sh"]

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b" , "0.0.0.0", "-p", "3000"]

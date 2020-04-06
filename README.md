# Description

This is demo project which focus on `graphql` built into a rails server. Look at `app/graphql/types/*_type.rb` for currently available queries.

Also provides an UI for currency exchange rates.

# Installation and starting the service

The service assumes that you `export` various ENV variables which are defined in `env.template`. However for easier setup the following approach is highly recommended:

* Duplicate `env.template` as `env.development` (for testing `env.test`)

* In your `env.development` set value for `SQL_DATABASE` (the name of the schema) and `CURRENCYLAYER_ACCESS_KEY` (access_key can be obtain by subscribing to basic (free) at https://currencylayer.com/)

## Via docker and docker-compose

Assumes/recommends that you have installed `docker` and `docker-compoes`

* Run `docker-compose up -d` to start a postgres instance and a rails server

* Run `docker-compose exec web bundle exec rails db:setup` (or any other `rails`/ `rake` command you prefer to setup up the system)

## On your system

Bundle and install the service as any other rails web server

# Using the service

* For currency UI open http://localhost:3000/ in your browser (:warning: If `seeds.rb` is applied be aware that the values are **fake** ones for demonstration purpose)

* For **graphql** perform POST request to `api/graphql` (see also [here](app/graphql/QUERY_EXAMPLES.md) for examples)

# Daily currency updates

When running `Via docker and docker-compose` a cron service is also started which updates the currencies every day at 8:00 am CET.

In order to get current values it is also possible to run `bundle exec rake currencylayer_import:daily` (or `... currencylayer_importhistorical FROM=YYYY-MM-DD TO=YYYY-MM-DD`)

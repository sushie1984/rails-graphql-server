# frozen_string_literal: true

require_relative 'boot'

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GraphqlServer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.currencylayer =
      OpenStruct.new(access_key: ENV.fetch('CURRENCYLAYER_ACCESS_KEY'),
                     cache: ENV.fetch('CURRENCYLAYER_CACHE'),
                     source: ENV.fetch('CURRENCYLAYER_SOURCE'),
                     currencies:
                      ENV.fetch('CURRENCYLAYER_CURRENCIES').split(','),
                     base_uri: ENV.fetch('CURRENCYLAYER_BASE_URI'))
  end
end

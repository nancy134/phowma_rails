require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PhowmaRails
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://server.phowma.com',
                'http://www.voter-information.com',
                'https://server.phowma.com',
                'https://www.voter-information.com'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
  end
end

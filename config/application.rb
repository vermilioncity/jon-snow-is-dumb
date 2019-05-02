require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JonSnowIsDumb
  class Application < Rails::Application
    config.load_defaults 5.2

    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.assets.precompile += %w( .svg .eot .woff .ttf )
    config.exceptions_app = self.routes
  end
end

require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Selfstarter
  class Application < Rails::Application

    config.assets.enabled = true
    config.assets.digest = true
    config.assets.precompile += %w( main.css.scss application.css bootstrap.css bootstrap.min.css checkout.css.scss footer.css.scss header.css.scss homepage.css.scss mystyle.scss.erb preorder.css.scss primitives.scss.erb reset.css share.css.scss variables.css.scss zocial.css )

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time.in_time_zone("Pacific Time (US & Canada)")

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end

require File.expand_path('../boot', __FILE__)

# The following set of includes replaces the default `require 'all'` as
# needed for mongoid, to remove active record
require "action_controller/railtie"
require "action_mailer/railtie"
# require "active_resource/railtie" # Comment this line for Rails 4.0+
require "rails/test_unit/railtie"
require "sprockets/railtie" # Uncomment this line for Rails 3.1+

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load .env.local
Dotenv.overload('.env.local') if Rails.env.development?
Dotenv.overload('.env.test') if Rails.env.test?

module BasicWebsite

  def self.default_host
    @default_host ||= ENV.fetch('DEFAULT_HOST')
  end

  class Application < Rails::Application

    config.autoload_paths += Dir[
      "#{config.root}/app/models/**/",
      "#{config.root}/lib",
      "#{config.root}/lib/**"
    ]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.raise_in_transactional_callbacks = true
  end
end

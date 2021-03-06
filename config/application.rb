require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Startlens
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Change timezon to JP
    config.time_zone = 'Asia/Tokyo'

    # Transform from snake_case by default to camelCase which can be interpreted by frontend js
    ActiveModelSerializers.config.key_transform = :camel_lower

    # Show error message in Japanese
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]

    # Set rspec settings. Generate rspec files by default and NOT generate Minitest files
    config.generators do |g|
      g.test_framework :rspec,
      # fixtures: false,
      view_specs: false,
      helper_specs: false,
      routing_specs: false
    end

    # Load the lib folder
    # DO NOT use autoload_paths because autoload isn't loaded in production environment
    config.eager_load_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('app', 'uploaders')
  end
end

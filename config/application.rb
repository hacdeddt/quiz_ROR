require_relative 'boot'
require 'rails/all'
require "csv"
require 'roo'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Quiz
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w( ckeditor/* ckeditor_assets/* *.png *.jpg *.jpeg *.gif img/*)
    config.encoding = "utf-8"
    config.assets.paths << "#{Rails}/vendor/assets/*"
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

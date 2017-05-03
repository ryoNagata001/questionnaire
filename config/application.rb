require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Questionnaire
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
  config.paths.add File.join('app', 'apis'), glob: File.join('**', '*.rb')
  config.autoload_paths += Dir[Rails.root.join('app', 'apis', '*')]
  config.autoload_paths += %W(#{config.root}/app/services)
  config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
  config.i18n.default_locale = :ja
  config.generators do |g|
    g.test_framework :rspec,
      fixtures: true,
      view_specs: false,
      helper_specs: false,
      routing_specs: false,
      controller_specs: true,
      request_specs: false
    g.fixture_replacement :factory_girl, dir: "spec/factories"
  end
  end
end

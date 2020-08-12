require_relative 'boot'

require 'rails'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module PosTagger
  class Application < Rails::Application
    config.load_defaults 6.0
  end
end

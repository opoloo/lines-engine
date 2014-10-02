module Lines
  class Engine < ::Rails::Engine
    isolate_namespace Lines

    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    require 'kaminari'
    require 'jquery-rails'
    require 'jquery-ui-rails'
    require 'jquery-fileupload-rails'
    require 'sanitize'
    require 'meta_tags'
    require 'rails3-jquery-autocomplete'

    initializer :assets do |config|
      Rails.application.config.assets.paths << root.join("app", "assets", "images")
      Rails.application.config.assets.paths << root.join("app", "assets", "stylesheets")
      Rails.application.config.assets.paths << root.join("app", "assets", "javascripts")
      Rails.application.config.assets.paths << root.join("app", "assets", "fonts")
    end

    # Initializer to combine this engines static assets with the static assets of the hosting site.
    initializer "static assets" do |app|
      app.middleware.insert_before(::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public")
    end

    initializer "lines.assets.precompile" do |app|
      app.config.assets.precompile += %w(lines/admin.css lines/admin.js)
    end

    initializer 'lines.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Lines::ApplicationHelper
      end
    end

    # RSpec configuration for generators
    config.generators do |g|
      g.test_framework :rspec,
        :fixtures => true,
        :view_specs => false,
        :helper_specs => false,
        :routing_specs => false,
        :controller_specs => true,
        :request_specs => true
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end

  end
end

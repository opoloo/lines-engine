module Lines
  class Engine < ::Rails::Engine
    isolate_namespace Lines

    require 'kaminari'
    require 'jquery-rails'
    require 'jquery-ui-rails'
    require 'jquery-fileupload-rails'

    initializer :assets do |config|
      Rails.application.config.assets.paths << root.join("app", "assets", "images")
      Rails.application.config.assets.paths << root.join("app", "assets", "stylesheets")
      Rails.application.config.assets.paths << root.join("app", "assets", "javascripts")
    end

    initializer "lines.assets.precompile" do |app|
      app.config.assets.precompile += %w(admin.css admin.js)
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

    # Require SSL for admin area and login form
    config.middleware.use Rack::SslEnforcer, :only => [%r{^/admin}, "/login", %r{^/sessions}],
      :ignore => '/assets', :strict => true if Rails.env.production?
      

  end
end

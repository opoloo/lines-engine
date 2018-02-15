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
      app.middleware.insert_after(::Rack::Runtime, ::ActionDispatch::Static, "#{root}/public")
    end

    initializer "lines.assets.precompile" do |app|
      app.config.assets.precompile += %w(lines/application.css lines/application.js lines/admin/admin.css lines/admin/admin.js)
    end

    initializer 'lines.action_controller' do |app|
      ActiveSupport.on_load :action_controller_base do
        helper Lines::ApplicationHelper
      end
    end

    initializer "host helpers" do |app|
      Lines::ApplicationController.helper app.helpers
    end

    # Disable error wrapper around form fields
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      class_attr_index = html_tag.index 'class="'

      if class_attr_index
        html_tag.insert class_attr_index+7, 'error '
      else
        html_tag.insert html_tag.index('>'), ' class="error"'
      end
    }

    # Load locale files for I18n module
    config.before_initialize do   
      I18n.enforce_available_locales = false                                                   
      config.i18n.load_path += Dir["#{config.root}/config/locales/**/*.yml"]
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

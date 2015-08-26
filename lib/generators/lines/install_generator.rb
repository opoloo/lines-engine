require 'rails/generators'

module Lines
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('..', __FILE__)

    def install_migrations
      rake "lines:install:migrations"
    end

    def add_routes
      route 'mount Lines::Engine => "/blog"'
    end

    def copy_stylesheets
      FileUtils.mkdir_p "app/assets/stylesheets/lines"
      directory('../../../app/assets/stylesheets/lines/', 'app/assets/stylesheets/lines/', {:exclude_pattern => /admin/} )
    end

    def copy_views
      directory('../../../app/views/lines', 'app/views/lines/', {:exclude_pattern => /admin|sessions/})
      directory('../../../app/views/kaminari', 'app/views/kaminari/')
      copy_file('../../../app/views/layouts/lines/application.html.erb', 'app/views/layouts/lines/application.html.erb')
      copy_file('../../../app/views/layouts/lines/preview.html.erb', 'app/views/layouts/lines/preview.html.erb')
    end

    def copy_config
      copy_file "../../../config/lines_config.yml", 'config/lines_config.yml'
    end

    def copy_locales
      directory "../../../config/locales/", 'config/locales/'
    end


    def load_seeds
      FileUtils.mkdir_p "vendor/screenshots"
      copy_file './templates/octorel.png', 'vendor/screenshots/octorel.png'
    end

    def add_user
      if yes?("Would you like to create an admin user? (y/N):")
        rake 'lines:add_user'
      end
    end

    def display_readme
      readme 'README'
    end

  end
end
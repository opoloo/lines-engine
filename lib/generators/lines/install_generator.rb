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
      copy_file "../../../app/assets/stylesheets/lines/lines_overrides.css.scss", "app/assets/stylesheets/lines/lines_overrides.css.scss"
      copy_file "../../../app/assets/stylesheets/lines/style.css.scss",           "app/assets/stylesheets/lines/style.css.scss"
      copy_file "../../../app/assets/stylesheets/lines/fonts.css.scss",           "app/assets/stylesheets/lines/fonts.css.scss"
      copy_file "../../../app/assets/stylesheets/lines/media_queries.css.scss",   "app/assets/stylesheets/lines/media_queries.css.scss"
      copy_file "../../../app/assets/stylesheets/lines/navbar.css.scss",          "app/assets/stylesheets/lines/navbar.css.scss"
      copy_file "../../../app/assets/stylesheets/lines/pygments.css.erb",         "app/assets/stylesheets/lines/pygments.css.erb"
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
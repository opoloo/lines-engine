require 'rails/generators'

module Lines
  class CopyStylesGenerator < Rails::Generators::Base
    source_root File.expand_path('..', __FILE__)

    def copy_stylesheets
      FileUtils.mkdir_p "app/assets/stylesheets/lines"
      directory('../../../app/assets/stylesheets/lines/', 'app/assets/stylesheets/lines/', {:exclude_pattern => /admin/} )
    end

  end
end
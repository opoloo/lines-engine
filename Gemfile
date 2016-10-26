source "https://rubygems.org"

# Declare your gem's dependencies in lines.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

#gem 'friendly_id', github: 'norman/friendly_id'
#gem 'rails3-jquery-autocomplete', github: 'francisd/rails3-jquery-autocomplete'
#gem 'meta-tags', require: 'meta_tags'
#gem 'rack-ssl-enforcer', require: 'rack/ssl-enforcer'
#gem 'acts-as-taggable-on', '~> 3.5.0'


group :development do
  gem 'capistrano'
  gem 'yard'
  gem 'autoprefixer-rails'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.14.0'
  gem 'factory_girl_rails', require: false
  gem 'railroady'
  gem 'thor'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'guard-rspec', '= 4.2.0'
  gem 'rb-inotify', '~> 0.9'
  gem 'launchy'
end

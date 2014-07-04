$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lines/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lines-engine"
  s.version     = Lines::VERSION
  s.authors     = ["Opoloo GbR"]
  s.email       = ["info@opoloo.de"]
  s.homepage    = "http://github.com/opoloo/lines-engine"
  s.summary     = "LINES is the open source blog platform you have been waiting for"
  s.description = "LINES lets you manage your posts in a clear, consistent frontend. The gracefully slender editor keeps your editing simple and lets you just splash around in your ideas. Once you're happy, just hit publish and see your text, code examples, images, and links shine."
  s.license     = "LGPL3"
  s.date        = '2010-04-28'

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "orm_adapter", "~> 0.1", ">= 0.5"
  s.add_dependency "thread_safe", "~> 0.1", ">= 0.3"
  s.add_dependency "railties", ">= 3.2.6", "< 5"
  s.add_dependency 'rmagick', "~> 2.13.2", ">= 2.13.2"
  s.add_dependency 'thor', "~> 0.1", ">= 0.19"
  s.add_dependency 'carrierwave', "~> 0.10.0", ">= 0.10.0"
  s.add_dependency 'kaminari', "~> 0.16.1", ">= 0.16.1"
  s.add_dependency 'pygments.rb', "~> 0.6.0", ">= 0.6.0"
  s.add_dependency 'redcarpet', "~> 3.1.2", ">= 3.1.2"
  s.add_dependency 'jquery-rails', "~> 3.1.0", ">= 3.1.0"
  s.add_dependency 'acts-as-taggable-on', '~> 3.2.6', ">= 3.2.6"
  s.add_dependency 'bcrypt', '~> 3.1.0', ">= 3.1.0"
  s.add_dependency 'simple_form', '~> 3', ">= 3.0.0", "< 4"
  s.add_dependency 'sitemap_generator', "~> 5.0.0", ">= 5.0.4"
  s.add_dependency 'jquery-fileupload-rails', "~> 0.4.1", ">= 0.4.1"
  s.add_dependency 'jquery-ui-rails', "~> 4", ">= 4.0.0"
  s.add_dependency 'sanitize', "~> 3.0.0", ">= 3.0.0"
  s.add_dependency 'sass-rails', "~> 4.0.0", '>= 4.0.0'
  s.add_dependency 'coffee-rails', '~> 4.0.0', '>= 4.0.0'
  s.add_dependency 'uglifier', '~> 2', '>= 2'
  s.add_dependency 'friendly_id', '~> 5.0.3', '>= 5.0.3'
  s.add_dependency 'rails3-jquery-autocomplete', '~> 1.0.11', '>= 1.0.11'
  s.add_dependency 'meta-tags', '~> 2.0.0', '>= 2.0.0'
  s.add_dependency 'rack-ssl-enforcer', '~> 0.2.7', '>= 0.2.7'

  s.add_development_dependency 'mysql2', '~> 2.9', '>= 2.9'

  s.test_files = Dir["spec/**/*"]
end

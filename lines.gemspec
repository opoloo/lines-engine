$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lines/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lines"
  s.version     = Lines::VERSION
  s.authors     = ["Opoloo GbR"]
  s.email       = ["info@opoloo.de"]
  s.homepage    = "http://www.opoloo.com"
  s.summary     = "LINES is the open source blog platform you have been waiting for"
  s.description = "LINES lets you manage your posts in a clear, consistent frontend. The gracefully slender editor keeps your editing simple and lets you just splash around in your ideas. Once you're happy, just hit publish and see your text, code examples, images, and links shine."
  s.license     = "LGPL3"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.0"
  s.add_dependency 'rmagick'
  s.add_dependency 'thor'
  s.add_dependency 'carrierwave'
  s.add_dependency 'kaminari'
  s.add_dependency 'pygments.rb'
  s.add_dependency 'redcarpet'
  s.add_dependency 'jquery-rails', '2.1.4'
  s.add_dependency 'acts-as-taggable-on', '>= 2.3.3'
  s.add_dependency 'bcrypt-ruby', '~> 3.0.0'
  s.add_dependency 'simple_form', '~> 3.0.0.rc'
  s.add_dependency 'sitemap_generator'
  s.add_dependency 'jquery-fileupload-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'sanitize'
  s.add_dependency 'sass-rails',   '>= 4.0.0'
  s.add_dependency 'coffee-rails', '>= 4.0.0'
  s.add_dependency 'uglifier', '>= 1.3.0'
  
  s.add_development_dependency "mysql2"

  s.test_files = Dir["spec/**/*"]
end

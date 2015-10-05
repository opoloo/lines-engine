$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lines/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lines-engine"
  s.version     = Lines::VERSION
  s.authors     = ["Opoloo GbR"]
  s.email       = ["info@opoloo.de"]
  s.homepage    = "http://lines.opoloo.com"
  s.summary     = "LINES is the open source blog platform you have been waiting for"
  s.description = "LINES lets you manage your posts in a clear, consistent frontend. The gracefully slender editor keeps your editing simple and lets you just splash around in your ideas. Once you're happy, just hit publish and see your text, code examples, images, and links shine."
  s.license     = "LGPL3"
  s.date        = Date.today.to_s
  s.required_ruby_version = '>= 1.9.3'
  s.cert_chain  = ['certs/lines-engine.pem']
  s.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/


  s.add_dependency 'orm_adapter', '>= 0.5'
  s.add_dependency 'thread_safe', '~> 0.1', '>= 0.3'
  s.add_dependency 'railties', '>= 3.2.6', '< 5'
  s.add_dependency 'rmagick', '~> 2.13.4', '>= 2.13.4'
  s.add_dependency 'thor', '~> 0.1', '>= 0.19'
  s.add_dependency 'carrierwave', '~> 0.10.0', '>= 0.10.0'
  s.add_dependency 'kaminari', '~> 0.16.1', '>= 0.16.1'
  s.add_dependency 'pygments.rb', '~> 0.6.0', '>= 0.6.0'
  s.add_dependency 'redcarpet', '~> 3.3.3', '>= 3.3.3'
  s.add_dependency 'jquery-rails', '< 5', '>= 3.1.0'
  s.add_dependency 'acts-as-taggable-on', '~> 3.5', '>= 3.5'
  s.add_dependency 'bcrypt', '~> 3.1.0', '>= 3.1.0'
  s.add_dependency 'sitemap_generator', '~> 5.0.0', '>= 5.0.5'
  s.add_dependency 'jquery-fileupload-rails', '~> 0.4.1', '>= 0.4.1'
  s.add_dependency 'jquery-ui-rails', '~> 5', '>= 5.0.0'
  s.add_dependency 'sanitize', '~> 4.0.0', '>= 3.0.0'
  s.add_dependency 'sass-rails', '>= 4.0.0'
  s.add_dependency 'coffee-rails', '< 5', '>= 4.0.0'
  s.add_dependency 'uglifier', '~> 2', '>= 2'
  s.add_dependency 'friendly_id', '~> 5.1.0', '>= 5.1.0'
  s.add_dependency 'rails3-jquery-autocomplete', '~> 1.0.11', '>= 1.0.11'
  s.add_dependency 'meta-tags', '~> 2.0.0', '>= 2.0.0'
  s.add_dependency 'bcrypt-ruby', '>= 3.0.0', '<= 4'
  s.add_dependency 'i18n', '~> 0.7.0'
  s.add_runtime_dependency 'rails', ['>= 3', '< 5']

  s.add_development_dependency 'mysql2', '~> 0.3.20', '< 0.4.0'
  s.add_development_dependency 'rspec-rails', '~> 2.14.2', '< 3'
  s.add_development_dependency 'rspec', '~> 2.14.1', '< 3'

  s.files         = `git ls-files`.split("\n").select{ |file_name| !(file_name =~ /^spec/) }
  s.test_files    = `git ls-files`.split("\n").select{ |file_name| (file_name =~ /^spec/) }
  s.executables   = s.executables   = s.files.grep(%r{^bin/}) do |f|
    f == 'bin/rails' ? nil : File.basename(f)
  end.compact
  s.require_paths = ["lib"]

end

$:.push File.expand_path("../lib", __FILE__)

require "lines/version"
require 'date'

Gem::Specification.new do |s|
  s.name        = "lines-engine"
  s.version     = Lines::VERSION
  s.authors     = ["Jochen Greif"]
  s.email       = ["lines@jochengreif.de"]
  s.homepage    = "http://lines.opoloo.com"
  s.summary     = "LINES is the open source blog platform you have been waiting for"
  s.description = "LINES lets you manage your posts in a clear, consistent frontend. The gracefully slender editor keeps your editing simple and lets you just splash around in your ideas. Once you're happy, just hit publish and see your text, code examples, images, and links shine."
  s.license     = "LGPL-3.0"
  s.date        = Date.today.to_s
  s.required_ruby_version = '>= 2.4'
  s.cert_chain  = ['certs/lines-engine.pem']
  s.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/


  s.add_runtime_dependency 'orm_adapter', '>= 0.5'
  s.add_runtime_dependency 'thread_safe', '>= 0.3'
  s.add_runtime_dependency 'railties', '>= 3.2.6', '< 7'
  s.add_runtime_dependency 'rmagick', '>= 2.13.4'
  s.add_runtime_dependency 'thor', '>= 0.19'
  s.add_runtime_dependency 'carrierwave', '>= 0.10.0'
  s.add_runtime_dependency 'kaminari', '>= 0.16.1'
  s.add_runtime_dependency 'pygments.rb', '>= 0.6.0'
  s.add_runtime_dependency 'redcarpet', '>= 3.3.3'
  s.add_runtime_dependency 'jquery-rails', '< 6', '>= 3.1.0'
  s.add_runtime_dependency 'acts-as-taggable-on', '>= 3.5'
  s.add_runtime_dependency 'bcrypt', '~> 3.1.0', '>= 3.1.0'
  s.add_runtime_dependency 'sitemap_generator', '>= 5.0.5'
  s.add_runtime_dependency 'jquery-fileupload-rails', '>= 0.4.1'
  s.add_runtime_dependency 'jquery-ui-rails', '>= 5.0.0'
  s.add_runtime_dependency 'sanitize', '>= 4.4.0'
  s.add_runtime_dependency 'sass-rails', '>= 4.0.0'
  s.add_runtime_dependency 'coffee-rails', '< 6', '>= 4.0.0'
  s.add_runtime_dependency 'uglifier', '>= 2'
  s.add_runtime_dependency 'friendly_id', '>= 5.2.4'
  s.add_runtime_dependency 'rails3-jquery-autocomplete', '>= 1.0.11'
  s.add_runtime_dependency 'meta-tags', '>= 2.0.0'
  s.add_runtime_dependency 'i18n', '>= 0.7.0'
  s.add_runtime_dependency 'sprockets-rails', '< 4'
  s.add_runtime_dependency 'rails', ['>= 3', '< 7']

  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'rspec-rails', '~> 2.14.2', '< 3'
  s.add_development_dependency 'rspec', '~> 2.14.1', '< 3'

  s.files         = `git ls-files`.split("\n").select{ |file_name| !(file_name =~ /^spec/) }
  s.test_files    = `git ls-files`.split("\n").select{ |file_name| (file_name =~ /^spec/) }
  s.executables   = s.executables   = s.files.grep(%r{^bin/}) do |f|
    f == 'bin/rails' ? nil : File.basename(f)
  end.compact
  s.require_paths = ["lib"]

end

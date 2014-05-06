require 'faker'

FactoryGirl.define do
  factory :picture, class: Lines::Picture do |f|
  	engine_root=File.join(File.dirname(__FILE__), '../')
    f.image { File.open(File.join(engine_root, 'support/images/example.jpg')) }
    article
  end
end
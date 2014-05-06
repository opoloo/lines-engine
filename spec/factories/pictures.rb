require 'faker'

FactoryGirl.define do
  factory :picture, class: Lines::Picture do |f|
    f.image { File.open(File.join(Lines::Engine.root, 'spec/support/images/example.jpg')) }
    article
  end
end
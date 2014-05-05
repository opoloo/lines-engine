require 'faker'

FactoryGirl.define do
  factory :picture do |f|
    f.image { File.open(File.join(Rails.root, '/spec/support/images/example.jpg')) }
    article
  end
end
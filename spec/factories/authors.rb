require 'faker'

FactoryGirl.define do
  factory :author do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.description "dsf"
  end
end
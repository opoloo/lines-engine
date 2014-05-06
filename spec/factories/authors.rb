require 'faker'

FactoryGirl.define do
  factory :author, class: Lines::Author do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.description "dsf"
  end
end
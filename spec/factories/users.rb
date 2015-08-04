require 'faker'

FactoryGirl.define do
  factory :user, class: Lines::User do |f|
    f.email { Faker::Internet.email }
    f.password "sekret1234"
    # f.password_confirmation "sekret"
  end

end
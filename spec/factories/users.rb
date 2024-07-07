FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_sign_in { false }
    first_memo { true }
  end
end
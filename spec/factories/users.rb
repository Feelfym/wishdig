FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    email { 'test@example' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
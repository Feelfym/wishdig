FactoryBot.define do
  factory :comparison do
    primary_item_id { 1 }
    secondary_item_id { 2 }
    association :user
  end
end

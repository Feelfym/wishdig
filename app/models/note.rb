class Note < ApplicationRecord
  validates :attribute_name, presence: true
  validates :primary_value, presence: true
  validates :secondary_value, presence: true
  belongs_to :comparison
end

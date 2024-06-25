class Note < ApplicationRecord
  validates :attribute_name, presence: true, length: { maximum: 40 }
  validates :primary_value, presence: true, length: { maximum: 255 }
  validates :secondary_value, presence: true, length: { maximum: 255 }
  belongs_to :comparison
end

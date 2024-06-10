class Memo < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000 }
  belongs_to :item
  belongs_to :user
end

class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 100_000_001}
  validates :will_purchase_date, format: { with: /\d{4}-\d{2}-\d{2}/, message: "must be in the format YYYY-MM-DD" }, allow_blank: true

  belongs_to :user
  has_many :memos, dependent: :destroy
end
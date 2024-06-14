class Comparison < ApplicationRecord
  belongs_to :primary_item, class_name: 'Item', foreign_key: 'primary_item_id'
  belongs_to :secondary_item, class_name: 'Item', foreign_key: 'secondary_item_id'
  has_many :notes, dependent: :destroy

  validate :different_items
  validates :primary_item_id, presence: true
  validates :secondary_item_id, presence: true

  private

  def different_items
    if primary_item_id == secondary_item_id
      errors.add(:secondary_item_id, "はアイテム1と異なるものを選択してください")
    end
  end
end

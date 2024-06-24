class Comparison < ApplicationRecord
  belongs_to :primary_item, class_name: 'Item', foreign_key: 'primary_item_id'
  belongs_to :secondary_item, class_name: 'Item', foreign_key: 'secondary_item_id'
  belongs_to :user
  has_many :notes, dependent: :destroy

  validate :different_items
  validate :unique_combination

  private

  def different_items
    if primary_item_id == secondary_item_id
      errors.add(:secondary_item_id, "はアイテム1と異なるものを選択してください")
    end
  end

  def unique_combination
    if Comparison.exists?(primary_item_id: primary_item_id, secondary_item_id: secondary_item_id) ||
       Comparison.exists?(primary_item_id: secondary_item_id, secondary_item_id: primary_item_id)
      errors.add(:base, "このアイテムの組み合わせはすでに存在します")
    end
  end
end

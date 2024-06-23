class Memo < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :title # ActiveHashのTitleモデルとのアソシエーション
  validates :content, presence: true, length: { maximum: 1000 }
  validates :title_id, numericality: { other_than: 1 , message: "can't be blank" }
  validates :item_id, presence: true

  belongs_to :item
end

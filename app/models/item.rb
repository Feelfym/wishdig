class Item < ApplicationRecord

  # バリデーション
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 100_000_001}
  validates :will_purchase_date, format: { with: /\d{4}-\d{2}-\d{2}/, message: "must be in the format YYYY-MM-DD" }, allow_blank: true
  validates :url, format: { with: /\A#{URI::regexp(%w(http https))}\z/, message: "must be a valid URL" }, allow_blank: true
  validates :purchased_flag, inclusion: { in: [true, false] }
  validates :purchased_date, format: { with: /\d{4}-\d{2}-\d{2}/, message: "must be in the format YYYY-MM-DD" }, allow_blank: true
  validates :score, presence: true

  # アソシエーション
  belongs_to :user
  has_many :memos, dependent: :destroy
  has_one_attached :image

  # スコープ
  scope :not_purchased, -> { where(purchased_flag: false) }
  scope :purchased, -> { where(purchased_flag: true) }
  scope :for_year_and_month, -> (year, month) {
    where('extract(year from will_purchase_date) = ? AND extract(month from will_purchase_date) = ?', year, month)
      .or(where('extract(year from purchased_date) = ? AND extract(month from purchased_date) = ?', year, month))
  }

  # クラスメソッド
  def self.total_price
    sum(:price)
  end

end

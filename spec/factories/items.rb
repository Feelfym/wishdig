FactoryBot.define do
  factory :item do
    name { 'item' }
    description { 'description' }
    price { 1000 }
    will_purchase_date { '2022-01-01' }
    url { 'http://example.com' }
    purchased_flag { false }
    purchased_date { '2022-01-01' }
    user
  end
end

# itemモデルのバリデーションは以下の通りです。
# validates :name, presence: true
# validates :description, presence: true
# validates :price, presence: true, numericality: { greater_than: 0, less_than: 100_000_001}
# validates :will_purchase_date, format: { with: /\d{4}-\d{2}-\d{2}/, message: "must be in the format YYYY-MM-DD" }, allow_blank: true
# validates :url, format: { with: /\A#{URI::regexp(%w(http https))}\z/, message: "must be a valid URL" }, allow_blank: true
# validates :purchased_flag, inclusion: { in: [true, false] }
# validates :purchased_date, format: { with: /\d{4}-\d{2}-\d{2}/, message: "must be in the format YYYY-MM-DD" }, allow_blank: true

# belongs_to :user
# has_many :memos, dependent: :destroy
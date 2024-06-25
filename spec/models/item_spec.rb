require 'rails_helper'

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

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe 'アイテム新規登録' do
    context '正しく登録できるケース' do
      it 'name, description, price, will_purchase_date, url, purchased_flag, purchased_dateがあれば登録できる' do
        expect(@item).to be_valid
      end

      it 'will_purchase_dateが空でも登録できる' do
        @item.will_purchase_date = ''
        expect(@item).to be_valid
      end

      it 'urlが空でも登録できる' do
        @item.url = ''
        expect(@item).to be_valid
      end

      it 'purchased_dateが空でも登録できる' do
        @item.purchased_date = ''
        expect(@item).to be_valid
      end

      it 'purchased_flagがtrueでも登録できる' do
        @item.purchased_flag = true
        expect(@item).to be_valid
      end

      it 'purchased_flagがfalseでも登録できる' do
        @item.purchased_flag = false
        expect(@item).to be_valid
      end

      it 'priceが1で登録できる' do
        @item.price = 1
        expect(@item).to be_valid
      end

      it 'priceが100000000でも登録できる' do
        @item.price = 100000000
        expect(@item).to be_valid
      end
    end

    context '登録できないケース' do
      it 'nameが空だと登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors[:name]).to include("can't be blank")
      end

      it 'nameが51文字以上だと登録できない' do
        @item.name = 'a' * 51
        @item.valid?
        expect(@item.errors[:name]).to include('is too long (maximum is 50 characters)')
      end

      it 'descriptionが空だと登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors[:description]).to include("can't be blank")
      end

      it 'descriptionが1001文字以上だと登録できない' do
        @item.description = 'a' * 1001
        @item.valid?
        expect(@item.errors[:description]).to include('is too long (maximum is 1000 characters)')
      end

      it 'priceが空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors[:price]).to include("can't be blank")
      end

      it 'priceが0だと登録できない' do
        @item.price = 0
        @item.valid?
        expect(@item.errors[:price]).to include('must be greater than 0')
      end

      it 'priceが100000001だと登録できない' do
        @item.price = 100000001
        @item.valid?
        expect(@item.errors[:price]).to include('must be less than 100000001')
      end

      it 'priceが文字列だと登録できない' do
        @item.price = 'price'
        @item.valid?
        expect(@item.errors[:price]).to include('is not a number')
      end

      it 'urlがhttp://example.com形式でないと登録できない' do
        @item.url = 'example.com'
        @item.valid?
        expect(@item.errors[:url]).to include('must be a valid URL')
      end
    end
  end
end

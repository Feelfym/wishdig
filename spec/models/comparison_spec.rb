require 'rails_helper'

RSpec.describe Comparison, type: :model do
  before do
    @comparison = FactoryBot.build(:comparison)
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end

  describe '比較新規登録' do
    context '正しく登録できるケース' do
      it 'primary_item_id, secondary_item_idがあれば登録できる' do
        @comparison.primary_item_id = @item1.id
        @comparison.secondary_item_id = @item2.id
        expect(@comparison).to be_valid
      end

    end
  
    context '登録できないケース' do
      it 'primary_item_idが空だと登録できない' do
        @comparison.primary_item_id = ''
        @comparison.secondary_item_id = @item2.id
        @comparison.valid?
        expect(@comparison.errors.full_messages).to include("Primary item must exist")
      end

      it 'secondary_item_idが空だと登録できない' do
        @comparison.primary_item_id = @item1.id
        @comparison.secondary_item_id = ''
        @comparison.valid?
        expect(@comparison.errors.full_messages).to include("Secondary item must exist")
      end

      it 'primary_item_idとsecondary_item_idが同じだと登録できない' do
        @comparison.primary_item_id = @item1.id
        @comparison.secondary_item_id = @item1.id
        @comparison.valid?
        expect(@comparison.errors.full_messages).to include("Secondary item はアイテム1と異なるものを選択してください")
      end
    end
  end
end

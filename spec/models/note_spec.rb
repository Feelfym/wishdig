require 'rails_helper'

RSpec.describe Note, type: :model do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
    @comparison = FactoryBot.create(:comparison, primary_item_id: @item1.id, secondary_item_id: @item2.id)
    @note = FactoryBot.build(:note, comparison_id: @comparison.id)
  end

  describe 'ノート新規登録' do
    context '正しく登録できるケース' do
      it 'attribute_name, primary_value, secondary_valueがあれば登録できる' do
        expect(@note).to be_valid
      end
    end

    context '登録できないケース' do
      it 'attribute_nameが空だと登録できない' do
        @note.attribute_name = ''
        @note.valid?
        expect(@note.errors.full_messages).to include("Attribute name can't be blank")
      end

      it 'primary_valueが空だと登録できない' do
        @note.primary_value = ''
        @note.valid?
        expect(@note.errors.full_messages).to include("Primary value can't be blank")
      end

      it 'secondary_valueが空だと登録できない' do
        @note.secondary_value = ''
        @note.valid?
        expect(@note.errors.full_messages).to include("Secondary value can't be blank")
      end
    end
  end
end
require 'rails_helper'

RSpec.describe Note, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item1 = FactoryBot.create(:item, user_id: @user.id)
    @item2 = FactoryBot.create(:item, user_id: @user.id)
    @comparison = FactoryBot.create(:comparison, primary_item_id: @item1.id, secondary_item_id: @item2.id, user_id: @user.id)
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

      it 'attribute_nameの文字数が41文字以上だと登録できない' do
        @note.attribute_name = 'a' * 41
        @note.valid?
        expect(@note.errors.full_messages).to include("Attribute name is too long (maximum is 40 characters)")
      end

      it 'primary_valueの文字数が256文字以上だと登録できない' do
        @note.primary_value = 'a' * 256
        @note.valid?
        expect(@note.errors.full_messages).to include("Primary value is too long (maximum is 255 characters)")
      end

      it 'secondary_valueの文字数が256文字以上だと登録できない' do
        @note.secondary_value = 'a' * 256
        @note.valid?
        expect(@note.errors.full_messages).to include("Secondary value is too long (maximum is 255 characters)")
      end
    end
  end
end
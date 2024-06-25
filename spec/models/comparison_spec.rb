require 'rails_helper'

RSpec.describe Comparison, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @comparison = FactoryBot.build(:comparison, user_id: @user.id)
    @item1 = FactoryBot.create(:item, user_id: @user.id)
    @item2 = FactoryBot.create(:item, user_id: @user.id)
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

      it 'current_userのitem以外をprimary_item_idに選択すると登録できない' do
        @user2 = FactoryBot.create(:user)
        @other_users_item = FactoryBot.create(:item, user_id: @user2.id)
        @comparison.primary_item_id = @other_users_item.id
        @comparison.secondary_item_id = @item2.id
        @comparison.valid?
        expect(@comparison.errors.full_messages).to include("比較するアイテムはユーザーが所有しているものでなければなりません")
      end

      it 'current_userのitem以外をsecondary_item_idに選択すると登録できない' do
        @user2 = FactoryBot.create(:user)
        @other_users_item = FactoryBot.create(:item, user_id: @user2.id)
        @comparison.primary_item_id = @item1.id
        @comparison.secondary_item_id = @other_users_item.id
        @comparison.valid?
        expect(@comparison.errors.full_messages).to include("比較するアイテムはユーザーが所有しているものでなければなりません")
      end
    end
  end
end

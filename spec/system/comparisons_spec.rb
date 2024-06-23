require 'rails_helper'

RSpec.describe "Comparisons", type: :system do
  before do
    @user = FactoryBot.create(:user)
    # そのユーザーのアイテムを2個作成
    @item1 = FactoryBot.create(:item, user_id: @user.id, name: 'アイテム1')
    @item2 = FactoryBot.create(:item, user_id: @user.id, name: 'アイテム2')
  end

  describe '比較新規登録' do
    context '正しく登録できるケース' do
      it 'primary_item_id, secondary_item_idがあれば登録できる' do
        # ログインする
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        find('input[name="commit"]').click
        sleep 1
        expect(current_path).to eq items_path
        # 比較新規登録画面へのボタンがある
        expect(page).to have_content('比較する')
        expect(
          all('.nav-item')[2].click
        ).to have_content('比較を作成')
        # 比較新規登録画面に遷移する
        visit new_comparison_path
        # primary_item_id, secondary_item_idをドロップダウンから選択する
        within('form') do
          select @item1.name, from: '1つめのアイテム'
          select @item2.name, from: '2つめのアイテム'
        end
        expect {
          click_button '作成'
          sleep 1
        }.to change { Comparison.count }.by(1)
      end
    end

    context '登録できないケース' do
      it 'primary_item_idが空だと登録できない' do
        # ログインする
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        find('input[name="commit"]').click
        sleep 1
        expect(current_path).to eq items_path
        # 比較新規登録画面へのボタンがある
        expect(page).to have_content('比較する')
        expect(
          all('.nav-item')[2].click
        ).to have_content('比較を作成')
        # 比較新規登録画面に遷移する
        visit new_comparison_path
        # secondary_item_idをドロップダウンから選択する
        within('form') do
          select @item2.name, from: '2つめのアイテム'
        end
        expect {
          click_button '作成'
          sleep 1
        }.to change { Comparison.count }.by(0)
      end

      it 'secondary_item_idが空だと登録できない' do
        # ログインする
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        find('input[name="commit"]').click
        sleep 1
        expect(current_path).to eq items_path
        # 比較新規登録画面へのボタンがある
        expect(page).to have_content('比較する')
        expect(
          all('.nav-item')[2].click
        ).to have_content('比較を作成')
        # 比較新規登録画面に遷移する
        visit new_comparison_path
        # primary_item_idをドロップダウンから選択する
        within('form') do
          select @item1.name, from: '1つめのアイテム'
        end
        expect {
          click_button '作成'
          sleep 1
        }.to change { Comparison.count }.by(0)
      end

      it 'primary_item_idとsecondary_item_idが同じだと登録できない' do
        # ログインする
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        find('input[name="commit"]').click
        sleep 1
        expect(current_path).to eq items_path
        # 比較新規登録画面へのボタンがある
        expect(page).to have_content('比較する')
        expect(
          all('.nav-item')[2].click
        ).to have_content('比較を作成')
        # 比較新規登録画面に遷移する
        visit new_comparison_path
        # primary_item_id, secondary_item_idをドロップダウンから選択する
        within('form') do
          select @item1.name, from: '1つめのアイテム'
          select @item1.name, from: '2つめのアイテム'
        end
        expect {
          click_button '作成'
          sleep 1
        }.to change { Comparison.count }.by(0)
      end

      it '同じ組み合わせの比較は新しく作成されない' do
        # ログインする
        visit new_user_session_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        find('input[name="commit"]').click
        sleep 1
        expect(current_path).to eq items_path
        # 比較新規登録画面へのボタンがある
        expect(page).to have_content('比較する')
        expect(
          all('.nav-item')[2].click
        ).to have_content('比較を作成')
        # 比較新規登録画面に遷移する
        visit new_comparison_path
        # primary_item_id, secondary_item_idをドロップダウンから選択する
        within('form') do
          select @item1.name, from: '1つめのアイテム'
          select @item2.name, from: '2つめのアイテム'
        end
        expect {
          click_button '作成'
          sleep 1
        }.to change { Comparison.count }.by(1)
        # 比較新規登録画面に遷移する
        visit new_comparison_path
        # primary_item_id, secondary_item_idをドロップダウンから選択する
        within('form') do
          select @item1.name, from: '1つめのアイテム'
          select @item2.name, from: '2つめのアイテム'
        end
        expect {
          click_button '作成'
          sleep 1
        }.to change { Comparison.count }.by(0)
      end
    end
  end
end

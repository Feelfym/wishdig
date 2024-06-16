require 'rails_helper'

RSpec.describe "Items", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user)
  end

  context 'アイテム新規登録ができるとき' do
    it 'ログインしたユーザーはアイテム新規登録ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path)
      # アイテム新規登録ページへのリンクがある
      expect(page).to have_content('新規アイテムを登録')
      # アイテム新規登録ページに移動する
      visit new_item_path
      # フォームに情報を入力する
      fill_in 'item_name', with: @item.name
      fill_in 'item_description', with: @item.description
      fill_in 'item_price', with: @item.price
      fill_in 'item_will_purchase_date', with: @item.will_purchase_date
      fill_in 'item_url', with: @item.url
      # 送信するとItemモデルのカウントが1上がる
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(1)
      # アイテム一覧ページに遷移する
      expect(current_path).to eq(items_path)
      # アイテム一覧ページには先ほど登録した内容のアイテムが存在する
      expect(page).to have_content(@item.name)

      # アイテム詳細ボタンが存在する
      expect(page).to have_content('詳細')
      # アイテム削除ボタンが存在する
      expect(page).to have_content('削除')
      # アイテム編集ボタンが存在する
      expect(page).to have_content('編集')
      # '購入した'ボタンが存在する
      expect(page).to have_content('購入した')
    end

    it '購入予定日とURLが空欄でも登録できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path)
      # アイテム新規登録ページへのリンクがある
      expect(page).to have_content('新規アイテムを登録')
      # アイテム新規登録ページに移動する
      visit new_item_path
      # フォームに情報を入力する
      fill_in 'item_name', with: @item.name
      fill_in 'item_description', with: @item.description
      fill_in 'item_price', with: @item.price
      # 送信するとItemモデルのカウントが1上がる
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(1)
      # アイテム一覧ページに遷移する
      expect(current_path).to eq(items_path)
      # アイテム一覧ページには先ほど登録した内容のアイテムが存在する
      expect(page).to have_content(@item.name)

        # アイテム詳細ボタンが存在する
        expect(page).to have_content('詳細')
        # アイテム削除ボタンが存在する
        expect(page).to have_content('削除')
        # アイテム編集ボタンが存在する
        expect(page).to have_content('編集')
        # '購入した'ボタンが存在する
        expect(page).to have_content('購入した')
    end
  end

  context 'アイテム新規登録ができないとき' do
    it 'ログインしていないとアイテム新規登録ページに遷移できない' do
      # トップページにいる
      visit root_path
      # アイテム新規登録ページへのリンクがない
      expect(page).to have_no_content('新規アイテムを登録')
    end

    it 'ログインしていても、アイテムの名前が空欄だとアイテム新規登録ができない' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path)
      # アイテム新規登録ページへのリンクがある
      expect(page).to have_content('新規アイテムを登録')
      # アイテム新規登録ページに移動する
      visit new_item_path
      # フォームに情報を入力する
      fill_in 'item_name', with: ''
      fill_in 'item_description', with: @item.description
      fill_in 'item_price', with: @item.price
      fill_in 'item_will_purchase_date', with: @item.will_purchase_date
      fill_in 'item_url', with: @item.url
      # 送信してもItemモデルのカウントは上がらない
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # アイテム新規登録ページに戻される
      expect(current_path).to eq(items_path)
    end

    it 'ログインしていても、アイテムの説明が空欄だとアイテム新規登録ができない' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path)
      # アイテム新規登録ページへのリンクがある
      expect(page).to have_content('新規アイテムを登録')
      # アイテム新規登録ページに移動する
      visit new_item_path
      # フォームに情報を入力する
      fill_in 'item_name', with: @item.name
      fill_in 'item_description', with: ''
      fill_in 'item_price', with: @item.price
      fill_in 'item_will_purchase_date', with: @item.will_purchase_date
      fill_in 'item_url', with: @item.url
      # 送信してもItemモデルのカウントは上がらない
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # アイテム新規登録ページに戻される
      expect(current_path).to eq(items_path)
    end
  end
end

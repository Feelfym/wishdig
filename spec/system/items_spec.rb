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
      # アイテム新規登録ページへのリンクは、「メニュー」というテキストをクリックすると表示される
      expect(page).to have_content('メニュー')
      # メニューをクリックすると、ドロップダウンメニューが表示される
      expect(
        all('.nav-item')[1].click
      ).to have_content('新規アイテムを登録')
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
    end

    it 'URLが空でも登録できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path)
      # アイテム新規登録ページへのリンクは、「メニュー」というテキストをクリックすると表示される
      expect(page).to have_content('メニュー')
      # メニューをクリックすると、ドロップダウンメニューが表示される
      expect(
        all('.nav-item')[1].click
      ).to have_content('新規アイテムを登録')
      # アイテム新規登録ページに移動する
      visit new_item_path
      # フォームに情報を入力する
      fill_in 'item_name', with: @item.name
      fill_in 'item_description', with: @item.description
      fill_in 'item_price', with: @item.price
      fill_in 'item_will_purchase_date', with: @item.will_purchase_date
      fill_in 'item_url', with: ''
      # 送信するとItemモデルのカウントが1上がる
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(1)
      # アイテム一覧ページに遷移する
      expect(current_path).to eq(items_path)
      # アイテム一覧ページには先ほど登録した内容のアイテムが存在する
      expect(page).to have_content(@item.name)
    end

    it '購入予定日が空でも登録できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path)
      # アイテム新規登録ページへのリンクは、「メニュー」というテキストをクリックすると表示される
      expect(page).to have_content('メニュー')
      # メニューをクリックすると、ドロップダウンメニューが表示される
      expect(
        all('.nav-item')[1].click
      ).to have_content('新規アイテムを登録')
      # アイテム新規登録ページに移動する
      visit new_item_path
      # フォームに情報を入力する
      fill_in 'item_name', with: @item.name
      fill_in 'item_description', with: @item.description
      fill_in 'item_price', with: @item.price
      fill_in 'item_will_purchase_date', with: ''
      fill_in 'item_url', with: @item.url
      # 送信するとItemモデルのカウントが1上がる
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(1)
      # アイテム一覧ページに遷移する
      expect(current_path).to eq(items_path)
      # アイテム一覧ページには先ほど登録した内容のアイテムが存在する
      expect(page).to have_content(@item.name)
    end
  end

  context 'アイテム新規登録ができないとき' do
    it 'ログインしていないとアイテム新規登録ページに遷移できない' do
      # トップページにいる
      visit root_path
      # アイテム新規登録ページへのリンクがない
      expect(page).to have_no_content('新規アイテムを登録')
    end

    it 'ログインしていても、アイテム名が空だとアイテム新規登録ができない' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path)
      # アイテム新規登録ページへのリンクは、「メニュー」というテキストをクリックすると表示される
      expect(page).to have_content('メニュー')
      # メニューをクリックすると、ドロップダウンメニューが表示される
      expect(
        all('.nav-item')[1].click
      ).to have_content('新規アイテムを登録')
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

    it 'ログインしていても、アイテムの説明が空だとアイテム新規登録ができない' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path)
      expect(page).to have_content('メニュー')
      expect(
        all('.nav-item')[1].click
      ).to have_content('新規アイテムを登録')
      visit new_item_path
      fill_in 'item_name', with: @item.name
      fill_in 'item_description', with: '' # 説明を空にする
      fill_in 'item_price', with: @item.price
      fill_in 'item_will_purchase_date', with: @item.will_purchase_date
      fill_in 'item_url', with: @item.url
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      expect(current_path).to eq(items_path)
    end
  end

  context 'アイテム詳細が閲覧できるとき' do
    it 'ログインしたユーザーは自分が登録したアイテムの詳細ページに遷移できる' do
      # アイテムを登録したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path)
      # アイテム詳細ページに遷移する
      visit item_path(@item)
      # アイテム詳細ページにはアイテムの内容が含まれている
      expect(page).to have_content(@item.name)
    end
  end

  context 'アイテム詳細が閲覧できないとき' do 
    it 'ログインしたユーザーは自分以外が登録したアイテムの詳細ページには遷移できない' do
      # 別のユーザーでログインする
      another_user = FactoryBot.create(:user)
      visit new_user_session_path
      fill_in 'Email', with: another_user.email
      fill_in 'Password', with: another_user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path) # アイテム一覧ページに遷移する
      # アイテム詳細ページに遷移する
      visit item_path(@item)
      # トップページに遷移したことを確認
      expect(current_path).to eq(items_path)
    end

    it 'ログインしていないとアイテムの詳細ページには遷移できない' do
      # トップページにいる
      visit root_path
      # アイテム詳細ページに遷移する
      visit item_path(@item)
      # サインインページに遷移したことを確認
      expect(current_path).to eq(new_user_session_path)
    end
  end

  context 'アイテム編集ができるとき' do
    it 'ログインしたユーザーは自分が登録したアイテムの編集ができる' do
      # アイテムを登録したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path)
      # アイテム詳細ページに遷移する
      visit item_path(@item)
      # アイテム詳細ページに編集ボタンがある
      expect(page).to have_content('編集')
      # 編集ページに遷移する
      visit edit_item_path(@item)
      # すでに投稿済みの内容がフォームに入っている
      expect(
        find('#item_name').value
      ).to eq(@item.name)
      # 投稿内容を編集する
      fill_in 'item_name', with: '編集'
      fill_in 'item_description', with: '編集'
      fill_in 'item_price', with: '1000'
      page.execute_script("document.getElementById('item_will_purchase_date').value = '2023-01-01'")
      fill_in 'item_url', with: 'https://example.com'
      # 編集してもItemモデルのカウントは変わらない
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # アイテム詳細ページに遷移する
      expect(current_path).to eq(items_path)
    end
  end

  context 'アイテム編集ができないとき' do
    it 'ログインしたユーザーは自分以外が登録したアイテムの編集画面には遷移できない' do
      # 別のユーザーでログインする
      another_user = FactoryBot.create(:user)
      visit new_user_session_path
      fill_in 'Email', with: another_user.email
      fill_in 'Password', with: another_user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path) # アイテム一覧ページに遷移する
      # アイテム詳細ページに遷移する
      visit item_path(@item)
      # トップページに遷移したことを確認
      expect(current_path).to eq(items_path)
    end
    
    it 'ログインしていないとアイテムの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # アイテム詳細ページに遷移する
      visit item_path(@item)
      # トップページに遷移したことを確認
      expect(current_path).to eq(new_user_session_path)
    end
  end

  context 'アイテム削除ができるとき' do
    it 'ログインしたユーザーは自分が登録したアイテムの削除ができる' do
      # アイテムを登録したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path)      
      # アイテム詳細ページに遷移する
      visit item_path(@item)
      # アイテム詳細ページに削除ボタンがある
      expect(page).to have_content('削除')
      
      # 削除ボタンを押したときにJSの確認ダイアログにOKと答える
      page.accept_confirm do
        find_link('削除', href: item_path(@item)).click
      end
      sleep 1
      # アイテム一覧ページに遷移する
      expect(current_path).to eq(items_path)
      # アイテム一覧ページにはアイテムの内容が存在しない
      expect(page).to have_no_content(@item.name)
    end
  end
  

  context 'アイテム削除ができないとき' do
    it 'ログインしたユーザーは自分以外が登録したアイテムの削除ができない' do
      # 別のユーザーでログインする
      another_user = FactoryBot.create(:user)
      visit new_user_session_path
      fill_in 'Email', with: another_user.email
      fill_in 'Password', with: another_user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path) # アイテム一覧ページに遷移する
      # アイテム詳細ページに遷移する
      visit item_path(@item)
      # トップページに遷移したことを確認
      expect(current_path).to eq(items_path)
    end

    it 'ログインしていないとアイテムの削除ができない' do
      # トップページにいる
      visit root_path
      # アイテム詳細ページに遷移する
      visit item_path(@item)
      # トップページに遷移したことを確認
      expect(current_path).to eq(new_user_session_path)
    end
  end

  context 'アイテムを購入済みにできるとき' do
    it 'ログインしたユーザーは自分が登録したアイテムを購入済みにできる' do
      # アイテムを登録したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      sleep 1
      expect(current_path).to eq(items_path)
      expect(page).to have_content('購入済みにする')
      # 購入ボタンを押すと、購入済みになる
      page.accept_confirm do
        find_link('購入済みにする', href: purchase_item_path(@item)).click
      end
      sleep 1
      # アイテム一覧ページに遷移する
      expect(current_path).to eq(items_path)
      # ほしいものリスト一覧ページには購入済みのアイテムが存在しない
      expect(page).to have_no_content(@item.name)
      # 購入済みリスト一覧ページには購入済みのアイテムが存在する
      visit purchased_items_path
      expect(page).to have_content(@item.name)
    end
  end
end
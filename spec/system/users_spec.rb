require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに遷移する' do
      visit items_path
      expect(page).to have_content('ユーザー新規登録')
      visit new_user_registration_path
      fill_in 'Name', with: @user.name
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation

      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)

      # 1秒待つ
      sleep 1
      expect(current_path).to eq(items_path)
      expect(page).to have_content('サインアウト')
      expect(page).to have_no_content('ユーザー新規登録')
      expect(page).to have_no_content('サインイン')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '名前が空欄の場合、ユーザー新規登録ができずに新規登録ページに戻ってくる' do
      visit items_path
      expect(page).to have_content('ユーザー新規登録')
      visit new_user_registration_path
      fill_in 'Name', with: ''
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation

      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 1秒待つ
      sleep 1
      expect(current_path).to eq(new_user_registration_path)
    end

    it 'メールアドレスが空欄の場合、ユーザー新規登録ができずに新規登録ページに戻ってくる' do
      visit items_path
      expect(page).to have_content('ユーザー新規登録')
      visit new_user_registration_path
      fill_in 'Name', with: @user.name
      fill_in 'Email', with: ''
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation

      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 1秒待つ
      sleep 1
      expect(current_path).to eq(new_user_registration_path)
    end

    it 'パスワードが空欄の場合、ユーザー新規登録ができずに新規登録ページに戻ってくる' do
      visit items_path
      expect(page).to have_content('ユーザー新規登録')
      visit new_user_registration_path
      fill_in 'Name', with: @user.name
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: @user.password_confirmation

      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 1秒待つ
      sleep 1
      expect(current_path).to eq(new_user_registration_path)
    end

    it 'パスワード（確認用）が空欄の場合、ユーザー新規登録ができずに新規登録ページに戻ってくる' do
      visit items_path
      expect(page).to have_content('ユーザー新規登録')
      visit new_user_registration_path
      fill_in 'Name', with: @user.name
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: ''

      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 1秒待つ
      sleep 1
      expect(current_path).to eq(new_user_registration_path)
    end

    it 'パスワードとパスワード（確認用）が一致しない場合、ユーザー新規登録ができずに新規登録ページに戻ってくる' do
      visit items_path
      expect(page).to have_content('ユーザー新規登録')
      visit new_user_registration_path
      fill_in 'Name', with: @user.name
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation + 'a'

      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 1秒待つ
      sleep 1
      expect(current_path).to eq(new_user_registration_path)
    end

    it 'すでに登録されているメールアドレスを入力した場合、ユーザー新規登録ができずに新規登録ページに戻ってくる' do
      @user.save
      visit items_path
      expect(page).to have_content('ユーザー新規登録')
      visit new_user_registration_path
      fill_in 'Name', with: @user.name
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation

      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 1秒待つ
      sleep 1
      expect(current_path).to eq(new_user_registration_path)
    end
  end
end

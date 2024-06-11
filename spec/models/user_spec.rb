require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '正しく登録できる' do
      it 'name, email, password, password_confirmationがあれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '登録できないケース' do
      it 'nameが空だと登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors[:name]).to include("can't be blank")
      end

      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors[:email]).to include("can't be blank")
      end

      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors[:password]).to include("can't be blank")
      end

      it 'password_confirmationが空だと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password = 'password'
        @user.password_confirmation = 'passward'
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include('has already been taken')
      end

      it 'passwordが6文字以上でないと登録できない' do
        @user.password = 'passw'
        @user.valid?
        expect(@user.errors[:password]).to include('is too short (minimum is 6 characters)')
      end

      it 'passwordが129文字以上だと登録できない' do
        @user.password = 'a' * 129
        @user.valid?
        expect(@user.errors[:password]).to include('is too long (maximum is 128 characters)')
      end

      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'testexample.com'
        @user.valid?
        expect(@user.errors[:email]).to include('is invalid')
      end
    end
  end
end

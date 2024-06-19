require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    let(:valid_user) { build(:user) }
    let(:invalid_user) { build(:user, password: 'pw', password_confirmation: 'pw') }

    context '有効なユーザーの場合' do
      it 'バリデーションが通ること' do
        expect(valid_user).to be_valid
        expect(valid_user.errors).to be_empty
      end
    end

    context '無効なユーザーの場合' do
      it 'パスワードが短すぎる場合、バリデーションエラーになること' do
        invalid_user.password = 'pw'
        invalid_user.password_confirmation = 'pw'
        invalid_user.valid?
        expect(invalid_user.errors[:password]).to include('は3文字以上で入力してください')
      end

      it 'パスワードが一致しない場合、バリデーションエラーになること' do
        valid_user.password_confirmation = 'different_password'
        valid_user.valid?
        expect(valid_user.errors[:password_confirmation]).to include('とPasswordの入力が一致しません')
      end

      it 'パスワード確認が空の場合、バリデーションエラーになること' do
        valid_user.password_confirmation = nil
        valid_user.valid?
        expect(valid_user.errors[:password_confirmation]).to include('を入力してください')
      end

      it 'メールアドレスが一意でない場合、バリデーションエラーになること' do
        create(:user, email: valid_user.email)
        valid_user.valid?
        expect(valid_user.errors[:email]).to include('はすでに存在します')
      end

      it 'メールアドレスが空の場合、バリデーションエラーになること' do
        valid_user.email = nil
        valid_user.valid?
        expect(valid_user.errors[:email]).to include('を入力してください')
      end

      it '名前が空の場合、バリデーションエラーになること' do
        valid_user.name = nil
        valid_user.valid?
        expect(valid_user.errors[:name]).to include('を入力してください')
      end

      it '名前が255文字を超える場合、バリデーションエラーになること' do
        valid_user.name = 'a' * 256
        valid_user.valid?
        expect(valid_user.errors[:name]).to include('は255文字以内で入力してください')
      end
    end
  end
end

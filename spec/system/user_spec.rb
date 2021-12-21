require 'rails_helper'
RSpec.describe '管理者機能', type: :system do
  describe 'ユーザ登録のテスト' do
    context 'ユーザ新規登録をする場合' do
      it 'ユーザの登録情報が表示される' do
        visit new_user_path
        fill_in 'user_name', with: 'test'
        fill_in 'user_email', with: 'test@test.com'
        fill_in 'user_password', with: '123456'
        fill_in 'user_password_confirmation', with: '123456'
        click_on '登録'
        expect(page).to have_content 'test'
      end
    end
    context 'ユーザがログインせずタスク一覧に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッション機能のテスト' do
    context "ログインする場合" do
      it 'ログインができること' do
        user2 = FactoryBot.create(:user2)
        visit new_session_path
        fill_in 'session_email', with: user2.email
        fill_in 'session_password', with: user2.password
        click_on 'ログイン'
        expect(current_path).to eq user_path(user2)
      end
      it '自分の詳細画面に飛べること' do
        user2 = FactoryBot.create(:user2)
        visit new_session_path
        fill_in 'session_email', with: user2.email
        fill_in 'session_password', with: user2.password
        click_on 'ログイン'
        click_link "Profile"
        expect(page).to have_content 'ユーザのページ'
      end
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do
        user2 = FactoryBot.create(:user2)
        user3 = FactoryBot.create(:user3)
        visit new_session_path 
        fill_in 'session_email', with: 'test@test.com'
        fill_in 'session_password', with: '111111'
        click_on 'ログイン'
        visit user_path(user3)
        expect(page).to have_content '権限がありません'
      end
      it 'ログアウトができること' do
        visit new_user_path
        fill_in 'user_name', with: 'test'
        fill_in 'user_email', with: 'test@test.com'
        fill_in 'user_password', with: '123456'
        fill_in 'user_password_confirmation', with: '123456'
        click_on '登録'
        click_link 'Logout'
        expect(page).to have_content "ログアウトしました"
      end
    end
  end
  describe '管理画面のテスト' do
    context '管理ユーザが操作する場合' do
      it '管理ユーザは管理画面にアクセスできること' do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session_email', with: 'admin@admin.com'
        fill_in 'session_password', with: '000000'
        click_on "ログイン"
        visit admin_users_path
        expect(page).to have_content "管理者画面" 
      end
      it '一般ユーザーは管理画面にはアクセスできないこと' do
        visit new_user_path
        fill_in 'user_name', with: 'test'
        fill_in 'user_email', with: 'test@test.com'
        fill_in 'user_password', with: '123456'
        fill_in 'user_password_confirmation', with: '123456'
        click_on '登録'
        visit admin_users_path
        expect(page).to have_content "管理者以外はアクセス出来ません" 
      end
      it '管理ユーザはユーザ新規登録ができること' do
        FactoryBot.create(:user)        
        visit new_session_path
        fill_in 'session_email', with: 'admin@admin.com'
        fill_in 'session_password', with: '000000'
        click_on "ログイン"
        visit admin_users_path
        click_on "User登録"
        fill_in 'user_name', with: 'test'
        fill_in 'user_email', with: 'test@test.com'
        fill_in 'user_password', with: '123456'
        fill_in 'user_password_confirmation', with: '123456'
        click_on "登録する"
        expect(page).to have_content "test@test.com"
      end
      it '管理ユーザはユーザの詳細画面にアクセスできること' do
        user = FactoryBot.create(:user)
        user2 = FactoryBot.create(:user2)
        visit new_session_path
        fill_in 'session_email', with: 'admin@admin.com'
        fill_in 'session_password', with: '000000'
        click_on "ログイン"
        visit admin_user_path(user2)
        expect(page).to have_content 'ユーザさんのタスク一覧'
      end
      it '管理ユーザはユーザの編集画面からユーザーを編集できること' do
        user = FactoryBot.create(:user)
        user2 = FactoryBot.create(:user2)
        visit new_session_path
        fill_in 'session_email', with: 'admin@admin.com'
        fill_in 'session_password', with: '000000'
        click_on "ログイン"
        visit admin_users_path
        visit edit_admin_user_path(id: user.id)
        fill_in 'user_name', with: 'edit'
        fill_in 'user_email', with: 'edit@test.com'
        fill_in 'user_password', with: '654321'
        fill_in 'user_password_confirmation', with: '654321'
        click_on '更新する'
        expect(page).to have_content "ユーザを更新しました！"
      end
      it '管理ユーザはユーザを削除できること' do
        user = FactoryBot.create(:user)
        user2 = FactoryBot.create(:user2)
        visit new_session_path
        fill_in 'session_email', with: 'admin@admin.com'
        fill_in 'session_password', with: '000000'
        click_on "ログイン"
        visit admin_users_path
        click_link '削除', href: admin_user_path(user2)
        expect {
          page.accept_confirm 'Are you sure？'
          expect(page).to have_content 'ユーザを削除しました！'
        }
      end
    end
  end
end
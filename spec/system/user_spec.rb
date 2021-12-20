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
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_on 'ログイン'
        expect(current_path).to eq user_path(user)
      end
      it '自分の詳細画面に飛べること' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_on 'ログイン'
        click_link "Profile"
        expect(page).to have_content 'ユーザのページ'
      end
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること' do
        user = FactoryBot.create(:user)
        second_user = FactoryBot.create(:second_user)
        visit new_session_path 
        fill_in 'session_email', with: 'test@test.com'
        fill_in 'session_password', with: '111111'
        click_on 'ログイン'
        visit user_path(second_user)
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



#   describe "管理画面のテスト" do
#     context "管理作成から各刻目のテスト" do

#       it "管理者は管理画面にアクセスできること" do
#         FactoryBot.create(:third_user)
#         visit new_session_path
#         fill_in "session_email", with: "admintest01@gmail.com​"
#         fill_in "session_password", with: "password"
#         click_on "log_in"
#         visit admin_users_path
#         expect(page).to have_content "ユーザーの一覧確認ページ" 
#       end

#       it "一般ユーザーは管理画面にはアクセスできない" do
#         visit new_user_path
#         fill_in 'user_name', with: 'usertest05'
#         fill_in 'user_email', with: 'usertest05@gmail.com'
#         fill_in 'user_password', with: 'password'
#         fill_in 'user_password_confirmation', with: 'password'
#         click_on 'アカウント作成'
#         visit admin_users_path
#         expect(page).to have_content "管理者以外はアクセスできません。" 
#       end

#       it "管理者はユーザ新規登録ができる" do
#         visit new_session_path
#         fill_in "session_email", with: "admintest01@gmail.com​"
#         fill_in "session_password", with: "password"
#         click_on "log_in"
#         visit admin_users_path
#         click_link "users_admin_new_link"
#         fill_in "user_name", with: "newtest01"
#         fill_in "user_email", with: "newtest01@gmail.com"
#         fill_in "user_password", with: "password"
#         fill_in "user_password_confirmation", with: "password"
#         click_on "登録する"
#         expect(page).to have_content "newtest01"
#       end

#       it "管理者はユーザの詳細画面へ行ける" do
#         @fourth_user = FactoryBot.create(:fourth_user)
#         visit new_session_path
#         fill_in "session_email", with: "admintest01@gmail.com​"
#         fill_in "session_password", with: "password"
#         click_on "log_in"
#         visit admin_user_path(@fourth_user)
#         expect(page).to have_content 'usertest11のページ'
#       end

#       it "管理者ユーザーの編集画面からユーザーの編集ができる" do
#         @fifth_user = FactoryBot.create(:fifth_user)
#         visit new_session_path
#         fill_in "session_email", with: "admintest01@gmail.com​"
#         fill_in "session_password", with: "password"
#         click_on "log_in"
#         visit edit_admin_user_path(id: @fifth_user.id)
#         fill_in 'user_name', with: 'testuser1000'
#         fill_in 'user_email', with: 'testuser1000@gmail.com'
#         fill_in 'user_password', with: 'password'
#         fill_in 'user_password_confirmation', with: 'password'
#         click_on '更新する'
#         expect(page).to have_content "testuser1000"
#       end

#       it "管理者はユーザーを削除できる" do
#         visit new_session_path
#         fill_in "session_email", with: "admintest01@gmail.com​"
#         fill_in "session_password", with: "password"
#         click_on "log_in"
#         @sixth_user = FactoryBot.create(:sixth_user)
#         visit admin_users_path
#         click_link '削除', href: admin_user_path(@sixth_user)
#         expect {
#           page.accept_confirm '削除しますか？'
#           expect(page).to have_content 'bar'
#         }
#       end

#     end
#   end

end
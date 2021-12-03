require 'rails_helper'
describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, title: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # ページ遷移直後でデバッグ
        # タスク一覧ページに遷移できているかを確認
        current_path
        # タスクがデータベースに作成されているかを確認
        Task.count
        # 表示するHTMLにタスク情報が入っているかを確認
        page.html
        expect(page).to have_content 'task'
      end
    end
  end
end
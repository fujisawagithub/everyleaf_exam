require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # let!(:task) { FactoryBot.create(:task) }
  # before do
  #   visit tasks_path
  # end
  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it '検索キーワードを含むタスクで絞り込まれる' do
        visit tasks_path
        fill_in 'タスク名', with: 'タイトル1'
        click_on 'Search'
        expect(page).to have_content 'タイトル1'
      end
    end
    context 'ステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        visit tasks_path
        select '未着手', from: 'ステータス'
        click_on 'Search'
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる' do
        visit tasks_path
        fill_in 'タスク名', with: 'タイトル1'
        select '未着手', from: 'ステータス'
        click_on 'Search'
        expect(page).to have_content 'タイトル1'
        expect(page).to have_content '未着手'
      end
    end
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'step3'
        fill_in 'task[content]', with: 'step3をクリアする'
        fill_in 'task[deadline]', with: DateTime.now
        select '未着手', from: 'task_status'
        click_on '登録'
        expect(page).to have_content 'step3'
        expect(page).to have_content 'step3をクリアする'
        expect(page).to have_content (DateTime.now).strftime('%Y-%m-%d')
        expect(page).to have_content '未着手'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'タイトル1'
      end
    end
  end
  context 'タスクが作成日時の降順に並んでいる場合' do
    it '新しいタスクが一番上に表示される' do
      task = FactoryBot.create(:second_task)
      visit tasks_path
      task_list = all('.row_title')
      expect(task_list[0]).to have_content 'タイトル2'
      expect(task_list[1]).to have_content 'タイトル1'
    end
  end
  context '終了期限でソートする場合' do
    it '終了期限の降順で表示される' do
      FactoryBot.create(:task, deadline: DateTime.now + 10)
      FactoryBot.create(:task, deadline: DateTime.now + 5)
      visit tasks_path
      click_link '終了期限'
      task_list = all('.row_dedline')
      expect(task_list[0]).to have_content (DateTime.now + 10).strftime('%Y-%m-%d')
      expect(task_list[1]).to have_content (DateTime.now + 5).strftime('%Y-%m-%d')
      expect(task_list[2]).to have_content (DateTime.now).strftime('%Y-%m-%d')
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        @task = FactoryBot.create(:task, title: 'task')
        visit task_path(@task)
        expect(page).to have_content 'task'
      end
    end
  end
end

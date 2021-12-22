require 'rails_helper'
RSpec.describe 'ラベリング機能', type: :system do
  let!(:user) { FactoryBot.create(:user2) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:second_task) { FactoryBot.create(:second_task, user: user) }
  let!(:label){FactoryBot.create(:label)}
  let!(:second_label){FactoryBot.create(:second_label)}
  before do
    visit new_session_path 
    fill_in 'session_email', with: 'test@test.com'
    fill_in 'session_password', with: '111111'
    click_on 'ログイン'
  end
describe 'ラベル検索機能' do
  context 'ラベルを新規作成した場合' do
    it '作成したタスクにラベルが含まれている' do
      visit new_task_path
      fill_in 'task_title', with: 'ラベル'
      fill_in 'task_content', with: 'ラベル検証'
      fill_in 'task_deadline', with: DateTime.now
      select '高', from: 'task_priority'
      select '未着手', from: 'task_status'
      check 'label1'
      click_on '登録'
      expect(page).to have_content 'ラベル'
      expect(page).to have_content 'ラベル検証'
      expect(page).to have_content (DateTime.now).strftime('%Y-%m-%d')
      expect(page).to have_content '高'
      expect(page).to have_content '未着手'
      expect(page).to have_content 'label1'
    end
  end
  context 'ラベル検索をした場合' do
    it '検索したラベルのタスクが表示される' do
      visit new_task_path
      fill_in 'task_title', with: 'ラベル'
      fill_in 'task_content', with: 'ラベル検証'
      fill_in 'task_deadline', with: DateTime.now
      select '高', from: 'task_priority'
      select '未着手', from: 'task_status'
      check 'label1'
      click_on '登録'
      visit tasks_path
      select'label1', from:'task[label_id]'
      click_on 'Search' 
      expect(page).to have_content 'label1'
      expect(page).to have_content 'ラベル' 
    end
  end
  context 'ラベルを編集した場合' do
    it '編集したラベルが表示される' do
      visit new_task_path
      fill_in 'task_title', with: 'ラベル'
      fill_in 'task_content', with: 'ラベル検証'
      fill_in 'task_deadline', with: DateTime.now
      select '高', from: 'task_priority'
      select '未着手', from: 'task_status'
      check 'label1'
      click_on '登録'
      visit tasks_path
      all('tbody tr')[0].click_link '編集'
      check 'label2'
      click_on '登録'
      expect(page).to have_content 'label1'
      expect(page).to have_content 'label2'
    end
  end
end
end
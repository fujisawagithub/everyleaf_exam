FactoryBot.define do
  factory :task  do
    title { 'タイトル1' }
    content { 'Factoryコンテント1' }
    deadline { DateTime.now }
    priority { '低' }
    status { '未着手' }
  end

  factory :second_task, class: Task do
    title { 'タイトル2' }
    content { 'Factoryコンテント2' }
    deadline { DateTime.now + 1 }
    priority { '中' }
    status { '着手中' }
  end

  factory :third_task, class: Task do
    title { 'タイトル3' }
    content { 'Factoryコンテント3' }
    deadline { DateTime.now + 2 }
    priority { '高' }
    status { '完了' }
  end
end

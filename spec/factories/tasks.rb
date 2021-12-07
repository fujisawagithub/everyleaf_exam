FactoryBot.define do
  factory :task do
    title { 'タイトル1' }
    content { 'Factoryコンテント1' }
    deadline { DateTime.now}
  end

  factory :second_task, class: Task do
    title { 'タイトル2' }
    content { 'Factoryコンテント2' }
    deadline { DateTime.now + 1 }
  end
end
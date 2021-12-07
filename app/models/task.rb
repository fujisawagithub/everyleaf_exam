class Task < ApplicationRecord
  validates :title,  presence: true, length: { maximum: 10 }
  validates :content,  presence: true, length: { maximum: 255 }
  validates :deadline, presence: true
  validates :status, presence: true
  enum status: {未着手: 0, 着手中: 1, 完了: 2}
end
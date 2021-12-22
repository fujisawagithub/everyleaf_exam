class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }
  validates :content,  presence: true, length: { maximum: 255 }
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 高: 0, 中: 1, 低: 2 }

  scope :scope_title, lambda { |title|
                        where('title LIKE ?', "%#{title}%")
                      }
  scope :scope_status, lambda { |status|
                         where(status: status)
                       }
end

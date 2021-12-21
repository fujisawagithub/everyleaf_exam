class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 6 }, allow_blank: true, on: :update
  has_secure_password
  has_many :tasks, dependent: :destroy
  before_destroy :confirm_admin_destroy
  before_update :confirm_admin_update

  private

  def confirm_admin_destroy
    throw :abort if User.where(admin: true).count <= 1 && self.admin == true
  end

  def confirm_admin_update
    if User.where(admin: true).count == 1 && self.admin == false
      errors.add(:admin,"は最低でも一人必要です。")
      throw :abort
    end
  end
end
